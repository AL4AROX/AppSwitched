# Script combinado de monitoreo y ejecución

Write-Host "=== INICIANDO SCRIPT COMBINADO ===" -ForegroundColor Green
Write-Host ""

# Parte 1: Time Changed Scanning
Write-Host 'Time Changed Scanning...' -ForegroundColor Yellow
try {
    Get-EventLog -LogName Security -InstanceId 4616 -ErrorAction Stop | Select -ExpandProperty TimeGenerated
} catch {
    Write-Host 'Nothing found'
}
Write-Host ''

# Parte 2: Journal Deleted logs scanning
Write-Host 'Journal Deleted logs scanning...' -ForegroundColor Yellow
Write-Host ''
try {
    Get-WinEvent -FilterHashtable @{LogName='Application'; Id=3079} -ErrorAction Stop | Select-Object -ExpandProperty TimeCreated
} catch {
    Write-Host 'Nothing found...'
}
Write-Host ''

# Parte 3: Descargar y ejecutar BamDeletedKeys
Write-Host "Descargando BamDeletedKeys..." -ForegroundColor Yellow
try {
    $tempDir = [System.IO.Path]::GetTempPath()
    $exePath = Join-Path $tempDir "BamDeletedKeys.exe"
    
    # Descargar el ejecutable
    Invoke-WebRequest -Uri "https://github.com/spokwn/BamDeletedKeys/releases/latest/download/BamDeletedKeys.exe" -OutFile $exePath -ErrorAction Stop
    
    Write-Host "Ejecutando BamDeletedKeys..." -ForegroundColor Yellow
    Start-Process -FilePath $exePath -Wait
    
    # Limpiar después de la ejecución (opcional)
    # Remove-Item $exePath -Force
} catch {
    Write-Host "Error al descargar/ejecutar BamDeletedKeys: $_" -ForegroundColor Red
}
Write-Host ''

# Parte 4: Ejecutar script 1 de Pastebin
Write-Host "Ejecutando script 1 desde Pastebin..." -ForegroundColor Yellow
try {
    Set-ExecutionPolicy -Scope Process -ExecutionPolicy Bypass -Force
    $script1 = Invoke-RestMethod -Uri 'https://pastebin.com/raw/57brWT3Z' -ErrorAction Stop
    Invoke-Expression $script1
} catch {
    Write-Host "Error al ejecutar script 1: $_" -ForegroundColor Red
}
Write-Host ''

# Parte 5: Ejecutar script 2 de Pastebin
Write-Host "Ejecutando script 2 desde Pastebin..." -ForegroundColor Yellow
try {
    Set-ExecutionPolicy -Scope Process -ExecutionPolicy Bypass -Force
    $script2 = Invoke-RestMethod -Uri 'https://pastebin.com/raw/qQLAT4wA' -ErrorAction Stop
    Invoke-Expression $script2
} catch {
    Write-Host "Error al ejecutar script 2: $_" -ForegroundColor Red
}
Write-Host ''

Write-Host "=== SCRIPT COMBINADO FINALIZADO ===" -ForegroundColor Green