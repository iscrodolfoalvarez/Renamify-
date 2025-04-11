# Renamify - Cambiar Extensiones de Archivos

**Renamify** es una herramienta gráfica desarrollada en **PowerShell** que permite cambiar fácilmente las extensiones de los archivos dentro de una carpeta o un archivo específico. Con una interfaz de usuario intuitiva, podrás seleccionar archivos o carpetas, especificar la extensión actual y la nueva extensión, y luego realizar el cambio con un solo clic.

## Características

- Cambia la extensión de archivos individuales o de múltiples archivos dentro de una carpeta.
- Interfaz gráfica de usuario amigable desarrollada con **Windows Forms**.
- Registra el proceso en un log para monitorear el estado de la operación.
- Limpia el log y los campos después de finalizar el proceso.
- Sección de información sobre el desarrollador con enlaces a **YouTube**, **GitHub** y **PayPal**.
  
## Requisitos

- **PowerShell** (Windows 10 o superior).
- **.NET Framework** (debería estar instalado por defecto en las versiones modernas de Windows).
- No es necesario instalar ninguna librería adicional, ya que la herramienta utiliza las librerías estándar de **Windows Forms**.

## Instrucciones de Uso

1. **Descargar el repositorio**:
   - Haz clic en el botón "Code" en la parte superior de la página del repositorio en GitHub y selecciona "Download ZIP".
   - Extrae el archivo ZIP en tu carpeta deseada.

2. **Ejecutar la herramienta**:
   - Navega a la carpeta donde extrajiste el archivo ZIP.
   - Haz doble clic en el archivo **Renamify.ps1**. Si se bloquea la ejecución de scripts, sigue estos pasos:
     1. Abre PowerShell como Administrador.
     2. Ejecuta el siguiente comando para permitir la ejecución de scripts:
        ```powershell
        Set-ExecutionPolicy RemoteSigned
        ```
     3. Confirma la opción **Y** para permitir cambios.

3. **Interfaz Gráfica**:
   - La herramienta abrirá una ventana de **Windows Forms** donde podrás seleccionar archivos o carpetas.
   - **Selecciona un archivo o carpeta**: Usa el botón "Seleccionar" para elegir la carpeta o archivo en el que deseas cambiar las extensiones.
   - **Introduce la extensión actual y la nueva extensión**: Rellena los campos con la extensión actual (sin el punto) y la nueva extensión.
   - **Ejecutar el cambio**: Haz clic en "Cambiar extensiones" para iniciar el proceso.
   - **Ver log de operaciones**: Los detalles del proceso aparecerán en la parte inferior de la ventana.

4. **Información del Desarrollador**:
   - En la parte inferior de la ventana, verás una sección con información sobre el desarrollador:
     - **YouTube**: Enlace a mi canal de YouTube [@iscrodolfoalvarez](https://www.youtube.com/@iscrodolfoalvarez).
     - **GitHub**: [GitHub de iscrodolfoalvarez](https://github.com/iscrodolfoalvarez).
     - **Donaciones**: Si deseas apoyar el proyecto, puedes hacerlo a través de [PayPal](https://www.paypal.com/paypalme/rodolfoalvarez90).

## Licencia

Este proyecto está bajo la Licencia MIT. Para más detalles, consulta el archivo **LICENSE** en el repositorio.

## Contribuciones

Si deseas contribuir al proyecto, ¡estás más que bienvenido! Puedes crear un **pull request** o abrir un **issue** para sugerir mejoras o reportar errores.

## Enlaces

- **YouTube**: [@iscrodolfoalvarez](https://www.youtube.com/@iscrodolfoalvarez)
- **GitHub**: [iscrodolfoalvarez](https://github.com/iscrodolfoalvarez)
- **Donaciones**: [PayPal](https://www.paypal.com/paypalme/rodolfoalvarez90)

¡Gracias por usar **Renamify**! Si encuentras algún error o tienes sugerencias, no dudes en ponerte en contacto.
