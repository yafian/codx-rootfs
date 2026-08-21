#!/bin/bash
# download-ubuntu.sh — Download Ubuntu base rootfs
set -e

echo "Downloading Ubuntu..."
mkdir -p dist

VERSION=$(curl -sL "https://cdimage.ubuntu.com/ubuntu-base/releases/" | grep -oP 'href="[0-9]+\.[0-9]+/' | sort -t. -k1,1n -k2,2n | tail -1 | grep -oP '[0-9]+\.[0-9]+')
echo "Latest Ubuntu: $VERSION"

curl -sL "https://cdimage.ubuntu.com/ubuntu-base/releases/${VERSION}/release/ubuntu-base-${VERSION}-base-arm64.tar.gz" -o ubuntu.tar.gz

mkdir -p rootfs
tar -xzf ubuntu.tar.gz -C rootfs
cd rootfs && tar -cf ../dist/ubuntu-aarch64.tar . && cd ..
xz -9 dist/ubuntu-aarch64.tar
rm -rf ubuntu.tar.gz rootfs

echo "Done: dist/ubuntu-aarch64.tar.xz"
