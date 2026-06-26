#!/bin/bash
# build-and-pack.sh — Compila mcpelauncher-manifest y empaqueta los binarios
# Uso: ./build-and-pack.sh v1.7.5 [/ruta/al/manifest]
set -e

VERSION="$1"
MANIFEST="${2:-$HOME/.local/src/mcpelauncher-manifest}"
DEST=$(dirname "$0")

if [ -z "$VERSION" ]; then
  echo "Uso: $0 v<VERSION> [/ruta/al/manifest]"
  echo "Ej:  $0 v1.7.5"
  exit 1
fi

if [ ! -d "$MANIFEST/build" ]; then
  echo "Configurando build en $MANIFEST ..."
  cmake -B "$MANIFEST/build" -G Ninja -DCMAKE_BUILD_TYPE=Release
fi

echo "Compilando mcpelauncher-manifest ..."
cmake --build "$MANIFEST/build"

BUILD="$MANIFEST/build"
echo "Copiando binarios a $DEST ..."

mkdir -p "$DEST/bin" "$DEST/libs_mc/lib"

# Del manifest principal
cp "$BUILD/mcpelauncher-client/mcpelauncher-client"  "$DEST/bin/"
cp "$BUILD/mcpelauncher-client/mcpelauncher-webview" "$DEST/bin/"
cp "$BUILD/mcpelauncher-client/mcpelauncher-error"   "$DEST/bin/"
cp "$BUILD/mcpelauncher-client/msa-daemon"           "$DEST/bin/"
cp "$BUILD/mcpelauncher-client/libmcpelauncher_mod.so" "$DEST/libs_mc/lib/x86_64/"
cp "$BUILD/gamecontrollerdb/gamecontrollerdb.txt"    "$DEST/libs_mc/"

# Pre-compilados del UI manifest (estables, trackeados en el repo)
cp "$DEST/prebuilt/"* "$DEST/bin/"

cat > "$DEST/bin/info.txt" <<EOF
==========================
VERSION: ${VERSION#v} (Release)
COMPILED: $(date -u +%Y%m%d-%H%M%S)
REPO: https://github.com/PlaGaPlusDev/mcpelauncher-manifest
ARCH: x86_64
==========================
EOF

echo "Empaquetando ..."
"$DEST/pack.sh" "$VERSION"
echo "✓ Listo: $(ls -1 $DEST/mcpelauncher_bins-$VERSION.tar.gz)"
