#!/bin/bash
# download-manjaro.sh — Download Manjaro ARM rootfs (kernel-stripped)
set -e

echo "Downloading Manjaro ARM..."
mkdir -p dist rootfs

VERSION=$(curl -sL "https://api.github.com/repos/manjaro-arm/rootfs/releases/latest" | python3 -c "import sys,json; print(json.load(sys.stdin)['tag_name'])")
echo "Latest Manjaro: $VERSION"

curl -sL "https://github.com/manjaro-arm/rootfs/releases/download/${VERSION}/Manjaro-ARM-aarch64-latest.tar.gz" -o manjaro.tar.gz

sudo tar -xzf manjaro.tar.gz -C rootfs 2>/dev/null
sudo rm -rf rootfs/boot/* rootfs/usr/lib/modules/* rootfs/usr/share/doc/*

sudo tar -cf "dist/manjaro-${VERSION}-aarch64.tar" -C rootfs .
xz -9 "dist/manjaro-${VERSION}-aarch64.tar"
sudo rm -rf manjaro.tar.gz rootfs

ls -lh "dist/manjaro-${VERSION}-aarch64.tar.xz"
echo "Done"
