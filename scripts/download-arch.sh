#!/bin/bash
# download-arch.sh — Download Arch Linux ARM rootfs (kernel-stripped)
set -e

echo "Downloading Arch Linux ARM..."
mkdir -p dist

VERSION=$(date +%Y%m%d)

curl -sL "http://os.archlinuxarm.org/os/ArchLinuxARM-aarch64-latest.tar.gz" -o arch.tar.gz

mkdir -p rootfs
tar -xzf arch.tar.gz -C rootfs --no-same-permissions --no-same-owner 2>/dev/null

# Strip kernel and firmware (proot doesn't need them)
rm -rf rootfs/boot/*
rm -rf rootfs/usr/lib/modules/*
rm -rf rootfs/usr/share/doc/*

cd rootfs && tar -cf "../dist/archlinux-${VERSION}-aarch64.tar" . && cd ..
xz -9 "dist/archlinux-${VERSION}-aarch64.tar"
rm -rf arch.tar.gz rootfs

echo "Done: dist/archlinux-${VERSION}-aarch64.tar.xz"
ls -lh "dist/archlinux-${VERSION}-aarch64.tar.xz"
