#!/usr/bin/env bash
# Install omarchy-about-animated into ~/.local/bin.
set -euo pipefail

repo=$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)
bin=${XDG_BIN_HOME:-$HOME/.local/bin}

need() {
  command -v "$1" >/dev/null 2>&1 || {
    echo "error: $1 is required but was not found in PATH" >&2
    exit 1
  }
}

need python3
need fastfetch
need hyprctl

mkdir -p "$bin"
install -m 755 "$repo/bin/omarchy-about-animated" "$bin/omarchy-about-animated"
install -m 755 "$repo/bin/omarchy-about" "$bin/omarchy-about"

cat <<EOF
installed:
  $bin/omarchy-about-animated
  $bin/omarchy-about

next: make it the About screen
  paste the block below into ~/.config/omarchy/extensions/omarchy-menu.jsonc
  (if the file is empty, wrap it in { ... } and remove the trailing comma)

EOF
sed 's/^/  /' "$repo/menu/omarchy-menu.jsonc"

cat <<'EOF'

then run:
  omarchy menu refresh

open it with:
  omarchy-about

optional settings:
  ~/.config/omarchy/about-animated.conf (see the README)
EOF
