# Requires Admin rights to write to HKEY_LOCAL_MACHINE
if (-not ([Security.Principal.WindowsPrincipal][Security.Principal.WindowsIdentity]::GetCurrent()).IsInRole([Security.Principal.WindowsBuiltInRole]::Administrator)) {
    Write-Warning "This script requires Administrator privileges to update the registry."
    Write-Warning "Please right-click the script and select 'Run as Administrator'."
    Pause
    exit
}

# 1. Get the current directory where this script is located
$CurrentDir = $PSScriptRoot

# 2. Escape the backslashes for the .reg file format (e.g., C:\Path -> C:\\Path)
$EscapedDir = $CurrentDir -replace '\\', '\\'

# 3. Define file paths
$TemplateFile = Join-Path -Path $CurrentDir -ChildPath "Install-Menu.template.reg"
$ActiveRegFile = Join-Path -Path $CurrentDir -ChildPath "Install-Menu.active.reg"

if (Test-Path -Path $TemplateFile) {
    # 4. Read the template, replace {app}, and write to a new active .reg file
    $RegContent = Get-Content -Path $TemplateFile
    $RegContent = $RegContent -replace '\{app\}', $EscapedDir
    $RegContent | Set-Content -Path $ActiveRegFile -Encoding utf8

    # 5. Import the newly generated .reg file into the Windows Registry silently
    Write-Host "Registering LLM Context Menu..." -ForegroundColor Cyan
    $process = Start-Process -FilePath "reg.exe" -ArgumentList "import `"$ActiveRegFile`"" -Wait -PassThru -WindowStyle Hidden

    if ($process.ExitCode -eq 0) {
        Write-Host "Installation completed successfully!" -ForegroundColor Green
    } else {
        Write-Host "There was an error updating the registry." -ForegroundColor Red
    }
} else {
    Write-Host "Error: Could not find '$TemplateFile' in the current directory." -ForegroundColor Red
}

Pause