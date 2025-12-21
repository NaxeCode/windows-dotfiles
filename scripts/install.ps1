param(
  [switch]$Symlink
)

$ErrorActionPreference = 'Stop'

$repoRoot = Split-Path -Parent $PSScriptRoot

function Ensure-Dir($path) {
  if (-not (Test-Path $path)) {
    New-Item -ItemType Directory -Path $path | Out-Null
  }
}

function Link-Or-Copy($source, $dest) {
  if (Test-Path $dest) {
    Remove-Item -Recurse -Force $dest
  }

  if ($Symlink) {
    New-Item -ItemType SymbolicLink -Path $dest -Target $source | Out-Null
  } else {
    Copy-Item -Recurse -Force $source $dest
  }
}

# Nushell
$nuRoot = Join-Path $env:APPDATA 'nushell'
Ensure-Dir $nuRoot
Link-Or-Copy (Join-Path $repoRoot 'nushell\config.nu') (Join-Path $nuRoot 'config.nu')
Link-Or-Copy (Join-Path $repoRoot 'nushell\env.nu') (Join-Path $nuRoot 'env.nu')

# Starship
$starshipRoot = Join-Path $env:USERPROFILE '.config'
Ensure-Dir $starshipRoot
Link-Or-Copy (Join-Path $repoRoot 'starship\starship.toml') (Join-Path $starshipRoot 'starship.toml')

# Yazi
$yaziRoot = Join-Path $env:APPDATA 'yazi\config'
Ensure-Dir $yaziRoot
Link-Or-Copy (Join-Path $repoRoot 'yazi\yazi.toml') (Join-Path $yaziRoot 'yazi.toml')
Link-Or-Copy (Join-Path $repoRoot 'yazi\keymap.toml') (Join-Path $yaziRoot 'keymap.toml')

Write-Host 'Dotfiles installed.' -ForegroundColor Green
