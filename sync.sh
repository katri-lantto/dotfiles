#!/usr/bin/env bash
# sync.sh — copy config files to/from ~/dev/config
#
# Usage:
#   ./sync.sh push   — copy ~/dev/config → live locations
#   ./sync.sh pull   — copy live configs → ~/dev/config

set -euo pipefail

REPO="$(cd "$(dirname "$0")" && pwd)"

# pairs: live location : repo location
declare -a FILES=(
  "$HOME/.tmux.conf:$REPO/tmux.conf"
  "$HOME/.config/tmux/flexoki.conf:$REPO/tmux/flexoki.conf"
  "$HOME/.config/nvim/init.lua:$REPO/nvim/init.lua"
  "$HOME/.config/nvim/KEYBINDS.md:$REPO/nvim/KEYBINDS.md"
  "$HOME/.config/nvim/lua/config/lazy.lua:$REPO/nvim/lua/config/lazy.lua"
  "$HOME/.config/nvim/lua/plugins/colorscheme.lua:$REPO/nvim/lua/plugins/colorscheme.lua"
  "$HOME/.config/nvim/lua/plugins/neo-tree.lua:$REPO/nvim/lua/plugins/neo-tree.lua"
  "$HOME/.config/nvim/lua/plugins/mason.lua:$REPO/nvim/lua/plugins/mason.lua"
  "$HOME/.config/nvim/lua/plugins/telescope.lua:$REPO/nvim/lua/plugins/telescope.lua"
  "$HOME/.config/nvim/lua/plugins/cmp.lua:$REPO/nvim/lua/plugins/cmp.lua"
  "$HOME/.config/kitty/kitty.conf:$REPO/kitty/kitty.conf"
)

usage() {
  echo "Usage: $0 [push|pull]"
  echo "  push  — copy repo configs to their live locations"
  echo "  pull  — copy live configs into this repo"
  exit 1
}

copy_files() {
  local src="$1"
  local dst="$2"
  mkdir -p "$(dirname "$dst")"
  cp "$src" "$dst"
  echo "  copied: $src → $dst"
}

[[ $# -ne 1 ]] && usage
CMD="$1"

case "$CMD" in
  push)
    echo "Pushing $REPO → live locations"
    for pair in "${FILES[@]}"; do
      live="${pair%%:*}"
      repo="${pair##*:}"
      if [[ -f "$repo" ]]; then
        copy_files "$repo" "$live"
      else
        echo "  skipped (not found): $repo"
      fi
    done
    ;;
  pull)
    echo "Pulling live configs → $REPO"
    for pair in "${FILES[@]}"; do
      live="${pair%%:*}"
      repo="${pair##*:}"
      if [[ -f "$live" ]]; then
        copy_files "$live" "$repo"
      else
        echo "  skipped (not found): $live"
      fi
    done
    ;;
  *)
    usage
    ;;
esac

echo "Done."
