#!/usr/bin/env bash
# https://hatchabot.com/install and /install.sh — runs the installer from the
# Hatchabot repository. The two files are identical; keep them so.
# /install exists for places that turn URLs into short links (LinkedIn): write it
# as  curl -fsSL 'hatchabot{.}com/install'  — curl expands {.} to a dot, and no
# URL-shaped text is left for them to rewrite.
# Arguments pass through: `curl -fsSL https://hatchabot.com/install.sh | bash -s -- beta`
#
# The installer itself comes from the release the stable channel names
# (channels.json on main), not from main, so a change to it reaches new users
# only when that release is promoted. It then resolves whichever channel was
# asked for. If no stable release can be read this stops: it never falls back
# to main. Only the dev channel (first argument `dev`, or HATCHABOT_CHANNEL=dev)
# runs main's installer, which then installs the stable channel unless another
# argument follows: `bash -s -- dev beta`.
set -euo pipefail
# Everything runs from main(), called on the last line: a download cut off
# part-way defines nothing that runs.
main() {
  RAW="https://raw.githubusercontent.com/hatchabot/hatchabot"
  die() { echo "$*" >&2; exit 1; }
  get() { curl -fsSL "$1" || die "Could not download $1 — check your connection and try again."; }

  if [ "${1:-}" = dev ] || [ "${HATCHABOT_CHANNEL:-}" = dev ]; then
    [ "${1:-}" != dev ] || shift
    unset HATCHABOT_CHANNEL
    SRC="$RAW/refs/heads/main/install.sh"
  else
    CHANNELS="$(get "$RAW/refs/heads/main/channels.json")"
    TAG="$(printf '%s\n' "$CHANNELS" | sed -nE 's/.*"stable"[[:space:]]*:[[:space:]]*"(v[0-9]+\.[0-9]+\.[0-9]+)".*/\1/p' | sed -n 1p)"
    [ -n "$TAG" ] || die "Hatchabot's channels.json names no stable release (or the answer was not that file: a captive portal or a proxy?) — try again later."
    # By tag explicitly: a branch with the same name can never shadow it.
    SRC="$RAW/refs/tags/$TAG/install.sh"
  fi
  SCRIPT="$(get "$SRC")"
  [ -n "$SCRIPT" ] || die "Downloaded an empty installer from $SRC — try again in a minute."
  exec bash -c "$SCRIPT" hatchabot-install "$@"
}
main "$@"
