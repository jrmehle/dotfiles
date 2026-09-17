#!/usr/bin/env bash
DOTFILES="$HOME/.dotfiles"

# Helper: backs up existing file if it's not already a symlink, then links
link() {
  local src="$1"   # file inside dotfiles repo
  local dst="$2"   # where it should appear on the system

  # Create parent directory if needed
  mkdir -p "$(dirname "$dst")"

  if [ -L "$dst" ]; then
    # Already a symlink, just re-point it
    ln -sf "$src" "$dst"
  elif [ -f "$dst" ] || [ -d "$dst" ]; then
    # Real file exists — back it up before overwriting
    echo "Backing up $dst → $dst.bak"
    mv "$dst" "$dst.bak"
    ln -sf "$src" "$dst"
  else
    # Nothing there, just link
    ln -sf "$src" "$dst"
  fi
}

# Shell
link "$DOTFILES/shell/.zshrc"            "$HOME/.zshrc"

# Git
link "$DOTFILES/shell/.gitconfig"          "$HOME/.gitconfig"

# Mise
link "$DOTFILES/mise/config.toml"        "$HOME/.config/mise/config.toml"

# Ghostty (path differs per OS)
case "$(uname -s)" in
  Darwin)
    link "$DOTFILES/ghostty/config" \
      "$HOME/Library/Application Support/com.mitchellh.ghostty/config"
    ;;
  Linux)
    link "$DOTFILES/ghostty/config"      "$HOME/.config/ghostty/config"
    ;;
esac
