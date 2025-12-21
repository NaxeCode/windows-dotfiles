param(
  [string]$Name = "Ubuntu-Dotfiles",
  [string]$InstallPath = "C:\WSL\Ubuntu-Dotfiles",
  [string]$Input = "C:\Backups\WSL\ubuntu-dotfiles.tar"
)

$ErrorActionPreference = "Stop"

if (-not (Test-Path $InstallPath)) {
  New-Item -ItemType Directory -Path $InstallPath | Out-Null
}

wsl --import $Name $InstallPath $Input
Write-Host "Imported $Name to $InstallPath from $Input" -ForegroundColor Green
