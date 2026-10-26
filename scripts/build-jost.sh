#!/usr/bin/env bash
# Rebuilds src/files/jost-{400,700}.woff2 from Google Fonts' variable Jost.
# Needs: python3 -m pip install fonttools brotli
# Usage: scripts/build-jost.sh /path/to/Jost[wght].ttf
set -euo pipefail

src="${1:?usage: build-jost.sh /path/to/Jost[wght].ttf}"
out="$(cd "$(dirname "$0")/.." && pwd)/src/files"
tmp="$(mktemp -d)"
trap 'rm -rf "$tmp"' EXIT

# Same ranges Google serves for its latin and latin-ext subsets: Malay plus the
# diacritics car makes use (Škoda, Citroën, Porsche's ß).
unicodes="U+0000-00FF,U+0131,U+0152-0153,U+02BB-02BC,U+02C6,U+02DA,U+02DC,U+0304,U+0308,U+0329,U+2000-206F,U+20AC,U+2122,U+2191,U+2193,U+2212,U+2215,U+FEFF,U+FFFD,U+0100-02BA,U+02BD-02C5,U+02C7-02CC,U+02CE-02D7,U+02DD-02FF,U+1D00-1DBF,U+1E00-1E9F,U+1EF2-1EFF,U+2020,U+20A0-20AB,U+20AD-20C4,U+2113,U+2C60-2C7F,U+A720-A7FF"

for w in 400 700; do
  fonttools varLib.instancer "$src" "wght=$w" --update-name-table -o "$tmp/jost-$w.ttf" -q
  pyftsubset "$tmp/jost-$w.ttf" --unicodes="$unicodes" --flavor=woff2 \
    --layout-features='*' --output-file="$out/jost-$w.woff2"
done
