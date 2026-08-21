#!/bin/bash
# download-alpine.sh — Download Alpine rootfs from official CDN
set -e

echo "Downloading Alpine Linux..."
mkdir -p dist

# Get latest stable version
VERSION=$(curl -sL "https://dl-cdn.alpinelinux.org/alpine/latest-stable/releases/aarch64/latest-releases.yaml" | grep "minirootfs" | head -1 | awk '{print $2}')
echo "Latest Alpine: $VERSION"

# Download
curl -sL "https://dl-cdn.alpinelinux.org/alpine/v${VERSION%.*}/releases/aarch64/alpine-minirootfs-${VERSION}-aarch64.tar.gz" -o alpine.tar.gz

# Repackage as .tar.xz
mkdir -p rootfs
tar -xzf alpine.tar.gz -C rootfs
cd rootfs && tar -cf ../dist/alpine-aarch64.tar . && cd ..
xz -9 dist/alpine-aarch64.tar
rm -rf alpine.tar.gz rootfs

echo "Done: dist/alpine-aarch64.tar.xz"
