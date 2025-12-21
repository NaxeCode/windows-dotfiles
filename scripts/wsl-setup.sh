#!/usr/bin/env bash
set -euo pipefail

REPO_ROOT="${REPO_ROOT:-/mnt/c/Dev/Github/windows-dotfiles}"

if [[ ! -d "$REPO_ROOT" ]]; then
  echo "Repo not found at $REPO_ROOT"
  echo "Set REPO_ROOT or clone the repo first."
  exit 1
fi

sudo apt-get update
sudo apt-get install -y curl git unzip build-essential pkg-config nodejs npm neovim zoxide

if ! command -v rustup >/dev/null 2>&1; then
  curl -sSf https://sh.rustup.rs | sh -s -- -y
fi

if [[ -f "$HOME/.cargo/env" ]]; then
  # shellcheck disable=SC1090
  source "$HOME/.cargo/env"
fi

if ! command -v yazi >/dev/null 2>&1; then
  cargo install --locked yazi-fm
fi

if ! command -v nu >/dev/null 2>&1; then
  cargo install --locked nu
fi

if ! command -v starship >/dev/null 2>&1; then
  curl -sS https://starship.rs/install.sh | sh -s -- -y
fi

if ! command -v carapace >/dev/null 2>&1; then
  if sudo apt-get install -y carapace; then
    true
  else
    echo "carapace not available via apt; install manually if needed."
  fi
fi

mkdir -p "$HOME/.config" "$HOME/.config/yazi" "$HOME/.config/nushell"

ln -sf "$REPO_ROOT/starship/starship.toml" "$HOME/.config/starship.toml"
ln -sf "$REPO_ROOT/yazi/yazi.toml" "$HOME/.config/yazi/yazi.toml"
ln -sf "$REPO_ROOT/yazi/keymap.toml" "$HOME/.config/yazi/keymap.toml"
ln -sf "$REPO_ROOT/nushell/config.nu" "$HOME/.config/nushell/config.nu"
ln -sf "$REPO_ROOT/nushell/env.nu" "$HOME/.config/nushell/env.nu"

if command -v nu >/dev/null 2>&1; then
  if ! grep -q "$HOME/.cargo/bin/nu" /etc/shells; then
    echo "$HOME/.cargo/bin/nu" | sudo tee -a /etc/shells >/dev/null
  fi
  chsh -s "$HOME/.cargo/bin/nu" || true
fi

echo "WSL setup complete."
