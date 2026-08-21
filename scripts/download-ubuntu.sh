#!/bin/bash
# download-ubuntu.sh — Download Ubuntu base rootfs from official CDN
set -e

echo "Downloading Ubuntu..."
mkdir -p dist

# Get latest version
VERSION=$(curl -sL "https://cdimage.ubuntu.com/ubuntu-base/releases/" | grep -oP 'href="[0-9]+\.[0-9]+"' | tail -1 | grep -oP '[0-9]+\.[0-9]+')
echo "Latest Ubuntu: $VERSION"

# Download
curl -sL "https://cdimage.ubuntu.com/ubuntu-base/releases/${VERSION}/release/ubuntu-base-${VERSION}-base-arm64.tar.gz" -o ubuntu.tar.gz

# Repackage as .tar.xz
mkdir -p rootfs
tar -xzf ubuntu.tar.gz -C rootfs
cd rootfs && tar -cf ../dist/ubuntu-aarch64.tar . && cd ..
xz -9 dist/ubuntu-aarch64.tar
rm -rf ubuntu.tar.gz rootfs

echo "Done: dist/ubuntu-aarch64.tar.xz"
