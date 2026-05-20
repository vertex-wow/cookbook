#!/bin/bash

set -euo pipefail

SCRIPT_DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)"

# Load local configuration
CONFIG_FILE="$SCRIPT_DIR/config.local.sh"
if [[ ! -f "$CONFIG_FILE" ]]; then
    echo "Error: Configuration file not found at $CONFIG_FILE" >&2
    echo "Please copy dev/config.sh.example to dev/config.local.sh and update it with your local paths" >&2
    exit 1
fi
source "$CONFIG_FILE"

ADDON_SUBPATH="/_retail_/Interface/AddOns"
WOW_ADDONS_DIR="${WOW_DIR%/}${ADDON_SUBPATH}"

if [[ ! -d "$WOW_ADDONS_DIR" ]]; then
    echo "Error: WoW AddOns directory not found at $WOW_ADDONS_DIR" >&2
    exit 1
fi

removed=0

while IFS= read -r -d '' addon_dir; do
    addon_name="$(basename "$addon_dir")"
    echo "Removing $addon_name..."
    rm -rf "$addon_dir"
    echo "  ✓ $addon_name removed"
    removed=$((removed + 1))
done < <(find "$WOW_ADDONS_DIR" -mindepth 1 -maxdepth 1 -type d -name "Example*_Vertex" -print0)

echo ""
if [[ $removed -eq 0 ]]; then
    echo "No matching addons found in $WOW_ADDONS_DIR"
else
    echo "✓ $removed addon(s) removed successfully!"
fi
