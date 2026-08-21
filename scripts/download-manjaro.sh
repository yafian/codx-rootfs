#!/bin/bash
# download-manjaro.sh — Download Manjaro ARM rootfs (kernel-stripped)
set -e

echo "Downloading Manjaro ARM..."
mkdir -p dist

VERSION=$(curl -sL "https://api.github.com/repos/manjaro-arm/rootfs/releases/latest" | python3 -c "import sys,json; print(json.load(sys.stdin)['tag_name'])")
echo "Latest Manjaro: $VERSION"

curl -sL "https://github.com/manjaro-arm/rootfs/releases/download/${VERSION}/Manjaro-ARM-aarch64-latest.tar.gz" -o manjaro.tar.gz

mkdir -p rootfs
tar -xzf manjaro.tar.gz -C rootfs --no-same-permissions --no-same-owner 2>/dev/null

# Strip kernel and firmware
rm -rf rootfs/boot/*
rm -rf rootfs/usr/lib/modules/*
rm -rf rootfs/usr/share/doc/*

cd rootfs && tar -cf "../dist/manjaro-${VERSION}-aarch64.tar" . && cd ..
xz -9 "dist/manjaro-${VERSION}-aarch64.tar"
rm -rf manjaro.tar.gz rootfs

echo "Done: dist/manjaro-${VERSION}-aarch64.tar.xz"
ls -lh "dist/manjaro-${VERSION}-aarch64.tar.xz"
