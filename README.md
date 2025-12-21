# Windows CLI dotfiles (Nushell + Starship + Yazi)

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
- Neovim config lives in a separate repo (kickstart fork).
