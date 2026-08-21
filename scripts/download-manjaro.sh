#!/bin/bash
# download-manjaro.sh — Download Manjaro ARM rootfs (proot-minimal)
set -e

echo "Downloading Manjaro ARM..."
mkdir -p dist rootfs

VERSION=$(curl -sL "https://api.github.com/repos/manjaro-arm/rootfs/releases/latest" | python3 -c "import sys,json; print(json.load(sys.stdin)['tag_name'])")
echo "Latest Manjaro: $VERSION"

curl -sL "https://github.com/manjaro-arm/rootfs/releases/download/${VERSION}/Manjaro-ARM-aarch64-latest.tar.gz" -o manjaro.tar.gz

sudo tar -xzf manjaro.tar.gz -C rootfs 2>/dev/null

sudo rm -rf rootfs/boot/*
sudo rm -rf rootfs/usr/lib/modules/*
sudo rm -rf rootfs/usr/lib/firmware/*
sudo rm -rf rootfs/usr/share/doc/*
sudo rm -rf rootfs/usr/share/man/*
sudo rm -rf rootfs/usr/share/info/*
sudo rm -rf rootfs/usr/share/locale/*
sudo rm -rf rootfs/usr/share/i18n/*
sudo rm -rf rootfs/usr/share/gtk-doc/*
sudo rm -rf rootfs/usr/share/glib-2.0/*
sudo rm -rf rootfs/var/cache/pacman/*

sudo tar -cf "dist/manjaro-${VERSION}-aarch64.tar" -C rootfs .
xz -9 "dist/manjaro-${VERSION}-aarch64.tar"
sudo rm -rf manjaro.tar.gz rootfs

ls -lh "dist/manjaro-${VERSION}-aarch64.tar.xz"
echo "Done"
