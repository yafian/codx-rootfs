#!/bin/bash
# download-manjaro.sh — Download Manjaro ARM rootfs from GitHub
set -e

echo "Downloading Manjaro ARM..."
mkdir -p dist

# Get latest release
VERSION=$(curl -sL "https://api.github.com/repos/manjaro-arm/rootfs/releases/latest" | grep -oP '"tag_name":"[0-9]+"' | grep -oP '[0-9]+')
echo "Latest Manjaro: $VERSION"

# Download
curl -sL "https://github.com/manjaro-arm/rootfs/releases/download/${VERSION}/Manjaro-ARM-aarch64-latest.tar.gz" -o manjaro.tar.gz

# Extract, remove kernel, repackage
mkdir -p rootfs
tar -xzf manjaro.tar.gz -C rootfs
rm -rf rootfs/boot/*
cd rootfs && tar -cf ../dist/manjaro-aarch64.tar . && cd ..
xz -9 dist/manjaro-aarch64.tar
rm -rf manjaro.tar.gz rootfs

echo "Done: dist/manjaro-aarch64.tar.xz"
