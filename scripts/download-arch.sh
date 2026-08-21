#!/bin/bash
# download-arch.sh — Download Arch Linux ARM rootfs
set -e

echo "Downloading Arch Linux ARM..."
mkdir -p dist

curl -sL "http://os.archlinuxarm.org/os/ArchLinuxARM-aarch64-latest.tar.gz" -o arch.tar.gz

mkdir -p rootfs
tar -xzf arch.tar.gz -C rootfs
rm -rf rootfs/boot/*
cd rootfs && tar -cf ../dist/archlinux-aarch64.tar . && cd ..
xz -9 dist/archlinux-aarch64.tar
rm -rf arch.tar.gz rootfs

echo "Done: dist/archlinux-aarch64.tar.xz"
