#!/usr/bin/env bash
# https://hatchabot.com/install.sh — runs the installer from the Hatchabot repository.
# Arguments pass through: `curl -fsSL https://hatchabot.com/install.sh | bash -s -- beta`
#
# The installer itself comes from the release the stable channel names, not
# from main, so a change to it reaches new users only when that release is
# promoted. It then resolves whichever channel was asked for.
set -euo pipefail
BASE="https://raw.githubusercontent.com/hatchabot/hatchabot"
TAG="$(curl -fsSL "$BASE/main/channels.json" 2>/dev/null | grep '"stable"' | sed -E 's/.*"(v[^"]+)".*/\1/' | head -1 || true)"
SRC="$BASE/${TAG:-main}/install.sh"
SCRIPT="$(curl -fsSL "$SRC")" || { echo "Could not download the installer from $SRC — check your connection and try again." >&2; exit 1; }
[ -n "$SCRIPT" ] || { echo "Downloaded an empty installer from $SRC — try again in a minute." >&2; exit 1; }
exec bash -c "$SCRIPT" hatchabot-install "$@"
