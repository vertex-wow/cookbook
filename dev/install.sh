#!/bin/bash

set -euo pipefail

SCRIPT_DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)"
PROJECT_DIR="$(cd "$SCRIPT_DIR/.." && pwd)"
DOCS_DIR="$PROJECT_DIR/docs"

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

installed=0

# Find all Addons/ directories under docs/ and install each addon within them
while IFS= read -r -d '' addons_dir; do
    while IFS= read -r -d '' addon_dir; do
        addon_name="$(basename "$addon_dir")"
        rel_path="docs/${addon_dir#"$DOCS_DIR/"}"

        echo "Installing $rel_path..."

        target_dir="$WOW_ADDONS_DIR/$addon_name"

        if [[ -d "$target_dir" ]]; then
            echo "  Removing existing $addon_name..."
            rm -rf "$target_dir"
        fi

        cp -r "$addon_dir" "$target_dir"
        echo "  ✓ $addon_name installed"
        installed=$((installed + 1))
    done < <(find "$addons_dir" -mindepth 1 -maxdepth 1 -type d -print0)
done < <(find "$DOCS_DIR" -type d -name "Addons" -print0)

echo ""
if [[ $installed -eq 0 ]]; then
    echo "No addons found under docs/"
else
    echo "✓ $installed addon(s) installed successfully!"
fi
