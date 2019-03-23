# Instalador Automatizado

Conjunto de herramientas que compilan y crean el instalador

- `Installer.bat`: Archivo batch que compila el proyecto `FontInstaller` y `FontInstallerInstaller` (este crea el installador).
- [`WixAutoInstaller.exe`][1]: Actualiza los valores para la version y el ID necesario para crear el instalador.

# Uso

- Abrir CMD
- Navegar hasta la ruta del archivo 
- Ejecutar el bat
  `Installer.bat <version>`
- Ejemplo:
  `Installer.bat 0.1.1.100`

[1]: https://github.com/Tecnologer/WixAutoInstaller