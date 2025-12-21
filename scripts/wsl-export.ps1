param(
  [string]$Distro = "Ubuntu",
  [string]$Output = "C:\Backups\WSL\ubuntu-dotfiles.tar"
)

$ErrorActionPreference = "Stop"

$outDir = Split-Path -Parent $Output
if (-not (Test-Path $outDir)) {
  New-Item -ItemType Directory -Path $outDir | Out-Null
}

wsl --export $Distro $Output
Write-Host "Exported $Distro to $Output" -ForegroundColor Green
