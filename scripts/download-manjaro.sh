#!/bin/bash
# download-manjaro.sh — Download Manjaro ARM rootfs
set -e

echo "Downloading Manjaro ARM..."
mkdir -p dist

VERSION=$(curl -sL "https://api.github.com/repos/manjaro-arm/rootfs/releases/latest" | python3 -c "import sys,json; print(json.load(sys.stdin)['tag_name'])")
echo "Latest Manjaro: $VERSION"

curl -sL "https://github.com/manjaro-arm/rootfs/releases/download/${VERSION}/Manjaro-ARM-aarch64-latest.tar.gz" -o manjaro.tar.gz

gunzip -c manjaro.tar.gz > "dist/manjaro-${VERSION}-aarch64.tar"
xz -9 "dist/manjaro-${VERSION}-aarch64.tar"
rm -f manjaro.tar.gz

echo "Done: dist/manjaro-${VERSION}-aarch64.tar.xz"
