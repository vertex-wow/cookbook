#!/usr/bin/env bash
set -euo pipefail

SCRIPT_DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)"
ROOT_DIR="$(dirname "$SCRIPT_DIR")"
CONFIG="$SCRIPT_DIR/config.local.sh"

if [[ ! -f "$CONFIG" ]]; then
  echo "Error: $CONFIG not found. Copy config.local.sh.example and update it." >&2
  exit 1
fi

# shellcheck source=dev/config.local.sh
source "$CONFIG"

RETAIL_DIR="${WOW_DIR}_retail_"
LIVE_DIR="$ROOT_DIR/_live"
REF_DIR="$ROOT_DIR/_reference"

mkdir -p "$LIVE_DIR" "$REF_DIR"

declare -A LINKS=(
  ["$LIVE_DIR/Addons"]="${RETAIL_DIR}/Interface/AddOns/"
  ["$LIVE_DIR/Logs"]="${RETAIL_DIR}/Logs"
  ["$LIVE_DIR/WoWChatLog.txt"]="${RETAIL_DIR}/Logs/WoWChatLog.txt"
  ["$LIVE_DIR/WTF-Account"]="${RETAIL_DIR}/WTF/Account/${WOW_ACCOUNT}/"
  ["$REF_DIR/wow-ui-source"]="../../_reference/wow-ui-source/"
)

for link in "${!LINKS[@]}"; do
  target="${LINKS[$link]}"
  if [[ -L "$link" ]]; then
    rm "$link"
  fi
  ln -s "$target" "$link"
  echo "Linked: $link -> $target"
done
