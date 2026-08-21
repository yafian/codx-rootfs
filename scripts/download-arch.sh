#!/bin/bash
# download-arch.sh — Download Arch Linux ARM rootfs
set -e

echo "Downloading Arch Linux ARM..."
mkdir -p dist

curl -sL "http://os.archlinuxarm.org/os/ArchLinuxARM-aarch64-latest.tar.gz" -o arch.tar.gz

# Decompress and recompress directly (avoids extraction symlink issues)
gunzip -c arch.tar.gz > dist/archlinux-aarch64.tar
xz -9 dist/archlinux-aarch64.tar
rm -f arch.tar.gz

echo "Done: dist/archlinux-aarch64.tar.xz"
