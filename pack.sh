#!/bin/bash
# pack.sh — Empaqueta bin/ y libs_mc/ en un tar.gz listo para release
# Uso: ./pack.sh v3.0.0

set -e

VERSION="$1"
if [ -z "$VERSION" ]; then
  echo "Usage: ./pack.sh v<VERSION>"
  echo "Example: ./pack.sh v3.0.0"
  exit 1
fi

DIRNAME="mcpelauncher_bins-$VERSION"
ARCHIVE="$DIRNAME.tar.gz"

if [ ! -d "bin" ] || [ ! -d "libs_mc" ]; then
  echo "Error: This script must be run from a directory containing 'bin/' and 'libs_mc/'."
  echo ""
  echo "Expected structure:"
  echo "  ./bin/"
  echo "    mcpelauncher-client"
  echo "    mcpelauncher-extract"
  echo "    gplaywrap"
  echo "    playdl"
  echo "  ./libs_mc/"
  echo "    lib/"
  echo "    gamecontrollerdb.txt"
  exit 1
fi

echo "Packaging $DIRNAME ..."

mkdir -p "$DIRNAME"
cp -r bin "$DIRNAME/"
cp -r libs_mc "$DIRNAME/"
tar -czf "$ARCHIVE" "$DIRNAME/"
rm -rf "$DIRNAME"

echo ""
echo "✓ Created: $ARCHIVE"
echo "  Size: $(du -h "$ARCHIVE" | cut -f1)"
echo ""
echo "Next steps:"
echo "  1. Create a new Release on GitHub"
echo "  2. Upload $ARCHIVE as an asset"
echo "  3. Tag it as $VERSION"
