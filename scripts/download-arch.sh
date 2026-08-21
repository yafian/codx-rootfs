#!/bin/bash
# download-arch.sh — Download Arch Linux ARM rootfs (kernel-stripped)
set -e

echo "Downloading Arch Linux ARM..."
mkdir -p dist rootfs

VERSION=$(date +%Y%m%d)

curl -sL "http://os.archlinuxarm.org/os/ArchLinuxARM-aarch64-latest.tar.gz" -o arch.tar.gz

sudo tar -xzf arch.tar.gz -C rootfs 2>/dev/null

rm -rf rootfs/boot/* rootfs/usr/lib/modules/* rootfs/usr/share/doc/*

sudo tar -cf "dist/archlinux-${VERSION}-aarch64.tar" -C rootfs .
xz -9 "dist/archlinux-${VERSION}-aarch64.tar"
sudo rm -rf arch.tar.gz rootfs

ls -lh "dist/archlinux-${VERSION}-aarch64.tar.xz"
echo "Done"
