cls
@IF "%1" == "" GOTO ErrorVersion
:: Environment Setup
:: For 2017
@call "C:\Program Files (x86)\Microsoft Visual Studio\2017\Community\Common7\Tools\VsDevCmd.bat"
:: Setting Variables..

@SET version=%1
@SET output=Output\
@SET input=..\..\FontInstaller\FontInstaller\bin\Release\
@IF "%PROCESSOR_ARCHITECTURE%"=="x86" (set CPUbit=x86) else (set CPUbit=x64)

:: msbuild /verbosity:m /p:Configuration=Release ..\FontInstaller\InstallerAutomation\InstallerAutomation.sln

@IF EXIST %output% GOTO NOTMAKE
@mkdir %output%

:NOTMAKE
@del /Q /S %input%
@del /Q /S %output%

@echo Building solution
msbuild /verbosity:m /p:Configuration=Release ..\..\FontInstaller\FontInstaller.sln
if ERRORLEVEL 1 exit /B

@echo Copy files to the output directory.
@copy "%input%DotNetZip.dll" 				%output%
@copy "%input%log4net.dll" 					%output%
@copy "%input%Syroot.KnownFolders.dll" 		%output%
@copy "%input%log4net.config" 				%output%
@copy "%input%FontInstaller.exe"       		%output%

:: HACK .. 3 second delay
ping 127.0.0.1 -n 4 > nul

WixAutoInstaller.exe -p "..\AppInstaller\Product.wxs" -v %version%

msbuild /verbosity:m /p:Configuration=Release "..\AppInstaller\AppInstaller.sln"
if ERRORLEVEL 1 exit /B

@copy "..\AppInstaller\bin\Release\AppInstaller.msi" "%output%FontInstaller_%version%.msi"	


@GOTO End
:ErrorVersion
@echo Missing parameter. Usage is "Installer.bat" "0.0.1.001" 
:End