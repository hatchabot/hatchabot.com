#!/usr/bin/env bash
# https://hatchabot.com/install.sh — runs the installer from the Hatchabot repository.
set -euo pipefail
exec bash -c "$(curl -fsSL https://raw.githubusercontent.com/hatchabot/hatchabot/main/install.sh)"
