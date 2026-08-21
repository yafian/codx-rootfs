#!/bin/bash
# download-ubuntu.sh — Download Ubuntu base rootfs
set -e

echo "Downloading Ubuntu..."
mkdir -p dist

VERSION="25.10"
echo "Ubuntu: $VERSION"

curl -sL "https://cdimage.ubuntu.com/ubuntu-base/releases/${VERSION}/release/ubuntu-base-${VERSION}-base-arm64.tar.gz" -o ubuntu.tar.gz

mkdir -p rootfs
tar -xzf ubuntu.tar.gz -C rootfs
cd rootfs && tar -cf ../dist/ubuntu-aarch64.tar . && cd ..
xz -9 dist/ubuntu-aarch64.tar
rm -rf ubuntu.tar.gz rootfs

echo "Done: dist/ubuntu-aarch64.tar.xz"
