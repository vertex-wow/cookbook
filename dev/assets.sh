#!/bin/bash
set -euo pipefail

# Convert SVG assets to WoW-compatible texture files.
# Searches docs/**/*.svg. For SVGs inside an Addons/ directory, outputs a TGA
# (vertically flipped, as WoW expects) alongside the source SVG. For all other
# SVGs it outputs a PNG (useful for README screenshots etc).
# Usage: ./dev/assets.sh

readonly SCRIPT_DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)"
readonly PROJECT_ROOT="$(dirname "$SCRIPT_DIR")"

if ! command -v rsvg-convert &> /dev/null; then
    echo "Error: Required tool 'rsvg-convert' not found. Install with:" >&2
    echo "  sudo apt install librsvg2-bin" >&2
    exit 1
fi

if command -v gm &> /dev/null; then
    CONVERT_CMD="gm convert"
elif command -v convert &> /dev/null; then
    CONVERT_CMD="convert"
else
    echo "Error: No image conversion tool found. Install one of:" >&2
    echo "  sudo apt install graphicsmagick" >&2
    echo "  sudo apt install imagemagick" >&2
    exit 1
fi

converted=0

while IFS= read -r -d '' svg_file; do
    dir="$(dirname "$svg_file")"
    base="$(basename "$svg_file" .svg)"
    rel="${svg_file#"$PROJECT_ROOT/"}"

    echo "Converting $rel..."

    rsvg-convert "$svg_file" -o "${dir}/${base}.png"

    if [[ "$svg_file" == */Addons/* ]]; then
        $CONVERT_CMD "${dir}/${base}.png" -flip "${dir}/${base}.tga"
        echo "  → ${base}.png"
        echo "  → ${base}.tga"
    else
        echo "  → ${base}.png"
    fi

    converted=$((converted + 1))
done < <(find "$PROJECT_ROOT/docs" -name "*.svg" -print0)

echo ""
echo "✓ $converted SVG(s) converted"
