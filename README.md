# Windows CLI dotfiles (Nushell + Starship + Yazi)

![Windows](https://img.shields.io/badge/Windows-11-0078D4?style=flat-square&logo=windows&logoColor=white)
![PowerShell](https://img.shields.io/badge/PowerShell-7+-5391FE?style=flat-square&logo=powershell&logoColor=white)
![Nushell](https://img.shields.io/badge/Nushell-0.102-4EAA25?style=flat-square&logo=gnu-bash&logoColor=white)
![Starship](https://img.shields.io/badge/Starship-Prompt-4A90E2?style=flat-square&logo=starship&logoColor=white)
![Yazi](https://img.shields.io/badge/Yazi-File%20Manager-111827?style=flat-square&logo=files&logoColor=white)

Minimal, Windows-first setup for a fast terminal workflow.

## What's included
- `nushell/` -> Nushell config (`config.nu`, `env.nu`)
- `starship/` -> Starship prompt (`starship.toml`)
- `yazi/` -> Yazi file manager config (`yazi.toml`, `keymap.toml`)
- `scripts/` -> Bootstrap script for Windows 11

## Quick install (PowerShell 7)
```powershell
Set-ExecutionPolicy -Scope Process Bypass
./scripts/install.ps1
```

## Notes
- This repo is Windows 11 focused.
- Neovim config lives in a separate repo (kickstart fork): https://github.com/NaxeCode/kickstart.nvim
