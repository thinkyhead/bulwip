#!/usr/bin/env bash
#
# makeicns.sh - Convert a 1024x1024 PNG into a macOS .icns file
# Author: GPT-5
#
# Usage: makeicns.sh input.png output.icns
#

[ $# -lt 2 ] && { echo "Usage: $0 input.png output.icns" ; exit 1 ; }

INPUT="$1"
OUTPUT="$2"
ICONSET="${OUTPUT%.icns}.iconset"

mkdir -p "$ICONSET"

# Generate scaled versions
sips --optimizeColorForSharing -z 16   16   "$INPUT" --out "$ICONSET/icon_16x16.png"
sips --optimizeColorForSharing -z 32   32   "$INPUT" --out "$ICONSET/icon_16x16@2x.png"
sips --optimizeColorForSharing -z 32   32   "$INPUT" --out "$ICONSET/icon_32x32.png"
sips --optimizeColorForSharing -z 64   64   "$INPUT" --out "$ICONSET/icon_32x32@2x.png"
sips --optimizeColorForSharing -z 128  128  "$INPUT" --out "$ICONSET/icon_128x128.png"
sips --optimizeColorForSharing -z 256  256  "$INPUT" --out "$ICONSET/icon_128x128@2x.png"
sips --optimizeColorForSharing -z 256  256  "$INPUT" --out "$ICONSET/icon_256x256.png"
sips --optimizeColorForSharing -z 512  512  "$INPUT" --out "$ICONSET/icon_256x256@2x.png"
sips --optimizeColorForSharing -z 512  512  "$INPUT" --out "$ICONSET/icon_512x512.png"
sips --optimizeColorForSharing -z 1024 1024 "$INPUT" --out "$ICONSET/icon_512x512@2x.png"

# Build the .icns
iconutil -c icns "$ICONSET" -o "$OUTPUT"

# Optional: remove the temporary .iconset
rm -r "$ICONSET"
