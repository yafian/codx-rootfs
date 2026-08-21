#!/bin/bash
# download-ubuntu.sh — Download Ubuntu rootfs (minimal via debian-installer)
set -e

echo "Downloading Ubuntu..."
mkdir -p dist

# Use Ubuntu minimal rootfs from cdimage (smaller than ubuntu-base)
curl -sL "http://cdimage.ubuntu.com/ubuntu-base/releases/25.10/release/ubuntu-base-25.10-base-arm64.tar.gz" -o ubuntu.tar.gz

mkdir -p rootfs
tar -xzf ubuntu.tar.gz -C rootfs
# Strip unnecessary files to reduce size
rm -rf rootfs/var/cache/* rootfs/usr/share/doc/*
cd rootfs && tar -cf ../dist/ubuntu-aarch64.tar . && cd ..
xz -9 -T0 dist/ubuntu-aarch64.tar
rm -rf ubuntu.tar.gz rootfs

ls -lh dist/ubuntu-aarch64.tar.xz
echo "Done: dist/ubuntu-aarch64.tar.xz"
