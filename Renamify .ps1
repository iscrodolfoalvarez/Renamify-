Add-Type -AssemblyName System.Windows.Forms
Add-Type -AssemblyName System.Drawing

# Crear la ventana principal
$form = New-Object System.Windows.Forms.Form
$form.Text = "Renamify - Cambiar Extensiones de Archivos"
$form.Size = New-Object System.Drawing.Size(600, 400)
$form.StartPosition = "CenterScreen"
$form.BackColor = "WhiteSmoke"

# Titulo grande "Renamify"
$lblTitulo = New-Object System.Windows.Forms.Label
$lblTitulo.Text = "Renamify"
$lblTitulo.Font = New-Object System.Drawing.Font("Segoe UI", 20, [System.Drawing.FontStyle]::Bold)
$lblTitulo.ForeColor = "#0078D7"
$lblTitulo.AutoSize = $true
$lblTitulo.Location = New-Object System.Drawing.Point(220, 5)
$form.Controls.Add($lblTitulo)

# Etiqueta carpeta/archivo
$lblCarpetaArchivo = New-Object System.Windows.Forms.Label
$lblCarpetaArchivo.Text = "Seleccionar:"
$lblCarpetaArchivo.Location = "20, 50"
$lblCarpetaArchivo.Size = "80, 20"
$form.Controls.Add($lblCarpetaArchivo)

# Cuadro de texto carpeta/archivo
$txtCarpetaArchivo = New-Object System.Windows.Forms.TextBox
$txtCarpetaArchivo.Location = "110, 50"
$txtCarpetaArchivo.Size = "350, 20"
$txtCarpetaArchivo.ReadOnly = $true
$form.Controls.Add($txtCarpetaArchivo)

# Boton seleccionar
$btnSeleccionar = New-Object System.Windows.Forms.Button
$btnSeleccionar.Text = "Seleccionar"
$btnSeleccionar.Location = "480, 48"
$btnSeleccionar.Size = "80, 25"
$btnSeleccionar.BackColor = "#0078D7"
$btnSeleccionar.ForeColor = "White"
$form.Controls.Add($btnSeleccionar)

# Etiqueta extension actual
$lblOldExt = New-Object System.Windows.Forms.Label
$lblOldExt.Text = "Extension actual:"
$lblOldExt.Location = "20, 90"
$form.Controls.Add($lblOldExt)

# Cuadro extension actual
$txtOldExt = New-Object System.Windows.Forms.TextBox
$txtOldExt.Location = "130, 90"
$txtOldExt.Size = "100, 20"
$form.Controls.Add($txtOldExt)

# Etiqueta nueva extension
$lblNewExt = New-Object System.Windows.Forms.Label
$lblNewExt.Text = "Nueva extension:"
$lblNewExt.Location = "250, 90"
$form.Controls.Add($lblNewExt)

# Cuadro nueva extension
$txtNewExt = New-Object System.Windows.Forms.TextBox
$txtNewExt.Location = "360, 90"
$txtNewExt.Size = "100, 20"
$form.Controls.Add($txtNewExt)

# Boton ejecutar
$btnEjecutar = New-Object System.Windows.Forms.Button
$btnEjecutar.Text = "Cambiar extensiones"
$btnEjecutar.Location = "230, 130"
$btnEjecutar.Size = "140, 30"
$btnEjecutar.BackColor = "#28A745"
$btnEjecutar.ForeColor = "White"
$form.Controls.Add($btnEjecutar)

# Cuadro de log
$txtLog = New-Object System.Windows.Forms.TextBox
$txtLog.Multiline = $true
$txtLog.ScrollBars = "Vertical"
$txtLog.ReadOnly = $true
$txtLog.BackColor = "#1E1E1E"
$txtLog.ForeColor = "White"
$txtLog.Location = "20, 180"
$txtLog.Size = "540, 140"
$txtLog.BorderStyle = "Fixed3D"
$form.Controls.Add($txtLog)

# Boton limpiar log
$btnLimpiarLog = New-Object System.Windows.Forms.Button
$btnLimpiarLog.Text = "Limpiar log"
$btnLimpiarLog.Location = "230, 330"
$btnLimpiarLog.Size = "140, 30"
$btnLimpiarLog.BackColor = "#FF6347"
$btnLimpiarLog.ForeColor = "White"
$form.Controls.Add($btnLimpiarLog)

# Accion al hacer clic en "Seleccionar"
$btnSeleccionar.Add_Click({
    $dialogResult = [System.Windows.Forms.MessageBox]::Show("Deseas seleccionar un archivo o una carpeta?", "Seleccionar opcion", [System.Windows.Forms.MessageBoxButtons]::YesNoCancel)
    
    if ($dialogResult -eq [System.Windows.Forms.DialogResult]::Yes) {
        $dialog = New-Object System.Windows.Forms.OpenFileDialog
        $dialog.InitialDirectory = [System.Environment]::GetFolderPath('MyDocuments')
        $dialog.Filter = "Todos los archivos (*.*)|*.*"
        $dialog.Title = "Seleccionar archivo"
        $dialog.CheckFileExists = $true
        $dialog.CheckPathExists = $true
        $dialog.Multiselect = $false

        if ($dialog.ShowDialog() -eq "OK") {
            $txtCarpetaArchivo.Text = $dialog.FileName
        }
    } elseif ($dialogResult -eq [System.Windows.Forms.DialogResult]::No) {
        $dialog = New-Object System.Windows.Forms.FolderBrowserDialog
        if ($dialog.ShowDialog() -eq "OK") {
            $txtCarpetaArchivo.Text = $dialog.SelectedPath
        }
    }
})

# Accion al hacer clic en "Cambiar extensiones"
$btnEjecutar.Add_Click({
    $carpetaArchivo = $txtCarpetaArchivo.Text
    $oldExt = $txtOldExt.Text.Trim()
    $newExt = $txtNewExt.Text.Trim()

    if ([string]::IsNullOrWhiteSpace($carpetaArchivo)) {
        [System.Windows.Forms.MessageBox]::Show("Por favor, selecciona un archivo o una carpeta.", "Error", [System.Windows.Forms.MessageBoxButtons]::OK, [System.Windows.Forms.MessageBoxIcon]::Error)
        return
    }

    if ([string]::IsNullOrWhiteSpace($oldExt) -or [string]::IsNullOrWhiteSpace($newExt)) {
        [System.Windows.Forms.MessageBox]::Show("Por favor, ingresa ambas extensiones.", "Error", [System.Windows.Forms.MessageBoxButtons]::OK, [System.Windows.Forms.MessageBoxIcon]::Error)
        return
    }

    $txtLog.AppendText("Iniciando proceso..." + [Environment]::NewLine)

    if (-not (Test-Path $carpetaArchivo)) {
        [System.Windows.Forms.MessageBox]::Show("La ruta seleccionada no es valida.", "Error", [System.Windows.Forms.MessageBoxButtons]::OK, [System.Windows.Forms.MessageBoxIcon]::Error)
        return
    }

    try {
        if ((Get-Item $carpetaArchivo).PSIsContainer) {
            $archivos = Get-ChildItem -Path $carpetaArchivo -Filter "*.$oldExt" -File

            if ($archivos.Count -eq 0) {
                $txtLog.AppendText("No se encontraron archivos con .$oldExt" + [Environment]::NewLine)
                return
            }

            foreach ($archivo in $archivos) {
                $nuevoNombre = [System.IO.Path]::GetFileNameWithoutExtension($archivo.Name) + "." + $newExt
                Rename-Item $archivo.FullName -NewName $nuevoNombre -ErrorAction Stop
                $txtLog.AppendText("Renombrado: $($archivo.Name) -> $nuevoNombre" + [Environment]::NewLine)
            }
        } else {
            $archivo = Get-Item -Path $carpetaArchivo
            if ($archivo.Extension -eq ".$oldExt") {
                $nuevoNombre = [System.IO.Path]::GetFileNameWithoutExtension($archivo.Name) + "." + $newExt
                Rename-Item $archivo.FullName -NewName $nuevoNombre -ErrorAction Stop
                $txtLog.AppendText("Renombrado: $($archivo.Name) -> $nuevoNombre" + [Environment]::NewLine)
            } else {
                $txtLog.AppendText("El archivo no tiene la extension .$oldExt." + [Environment]::NewLine)
            }
        }
    } catch {
        $txtLog.AppendText("Error con el proceso: $_" + [Environment]::NewLine)
    }

    # Limpiar campos despues de finalizar
    $txtCarpetaArchivo.Text = ""
    $txtOldExt.Text = ""
    $txtNewExt.Text = ""
    $txtLog.AppendText("Proceso finalizado." + [Environment]::NewLine)
})

# Accion al hacer clic en "Limpiar log"
$btnLimpiarLog.Add_Click({
    $txtLog.Clear()
})


# === Apartado de informacion del desarrollador ===
$groupDev = New-Object System.Windows.Forms.GroupBox
$groupDev.Text = "Desarrollado por:"
$groupDev.Location = "20, 370"
$groupDev.Size = "540, 90"
$groupDev.BackColor = "WhiteSmoke"
$form.Controls.Add($groupDev)

# Etiqueta con nombre
$lblNombreDev = New-Object System.Windows.Forms.Label
$lblNombreDev.Text = "iscrodolfoalvarez"
$lblNombreDev.Location = "10, 20"
$lblNombreDev.Size = "200, 20"
$lblNombreDev.Font = New-Object System.Drawing.Font("Segoe UI", 10, [System.Drawing.FontStyle]::Bold)
$groupDev.Controls.Add($lblNombreDev)

# Link YouTube
$linkYT = New-Object System.Windows.Forms.LinkLabel
$linkYT.Text = "YouTube"
$linkYT.Location = "10, 45"
$linkYT.Size = "100, 20"
$linkYT.LinkBehavior = "HoverUnderline"
$linkYT.ForeColor = "Blue"
$linkYT.Add_Click({
    Start-Process "https://www.youtube.com/@iscrodolfoalvarez"
})
$groupDev.Controls.Add($linkYT)

# Link PayPal
$linkPayPal = New-Object System.Windows.Forms.LinkLabel
$linkPayPal.Text = "Donar via PayPal"
$linkPayPal.Location = "120, 45"
$linkPayPal.Size = "120, 20"
$linkPayPal.LinkBehavior = "HoverUnderline"
$linkPayPal.ForeColor = "Blue"
$linkPayPal.Add_Click({
    Start-Process "https://www.paypal.com/paypalme/rodolfoalvarez90"
})
$groupDev.Controls.Add($linkPayPal)

# Link GitHub
$linkGitHub = New-Object System.Windows.Forms.LinkLabel
$linkGitHub.Text = "GitHub"
$linkGitHub.Location = "260, 45"
$linkGitHub.Size = "100, 20"
$linkGitHub.LinkBehavior = "HoverUnderline"
$linkGitHub.ForeColor = "Blue"
$linkGitHub.Add_Click({
    Start-Process "https://github.com/iscrodolfoalvarez"
})
$groupDev.Controls.Add($linkGitHub)

# Ajustar tamano final del formulario para que se vea todo
$form.Height = 520



# Mostrar ventana
[void]$form.ShowDialog()
