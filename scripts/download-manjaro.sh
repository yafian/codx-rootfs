#!/bin/bash
# download-manjaro.sh — Download Manjaro ARM rootfs (proot-minimal)
set -e

echo "Downloading Manjaro ARM..."
mkdir -p dist rootfs

VERSION=$(curl -sL "https://api.github.com/repos/manjaro-arm/rootfs/releases/latest" | python3 -c "import sys,json; print(json.load(sys.stdin)['tag_name'])")
echo "Latest Manjaro: $VERSION"

curl -fsSL --connect-timeout 30 --max-time 1800 \
  "https://github.com/manjaro-arm/rootfs/releases/download/${VERSION}/Manjaro-ARM-aarch64-latest.tar.gz" \
  -o manjaro.tar.gz

sudo tar -xzf manjaro.tar.gz -C rootfs
sudo chown -R $(id -u):$(id -g) rootfs

rm -rf rootfs/boot/*
rm -rf rootfs/usr/lib/modules/*
rm -rf rootfs/usr/lib/firmware/*
rm -rf rootfs/usr/share/doc/*
rm -rf rootfs/usr/share/man/*
rm -rf rootfs/usr/share/info/*
rm -rf rootfs/usr/share/locale/*
rm -rf rootfs/usr/share/i18n/*
rm -rf rootfs/usr/share/gtk-doc/*
rm -rf rootfs/usr/share/glib-2.0/*
rm -rf rootfs/var/cache/pacman/*

tar -cf "dist/manjaro-${VERSION}-aarch64.tar" -C rootfs .
xz -9 "dist/manjaro-${VERSION}-aarch64.tar"
rm -rf manjaro.tar.gz rootfs

ls -lh "dist/manjaro-${VERSION}-aarch64.tar.xz"
echo "Done"

echo "{\"id\":\"manjaro\",\"version\":\"${VERSION}\",\"codename\":\"\",\"fileName\":\"manjaro-${VERSION}-aarch64.tar.xz\"}" >> dist/metadata.jsonl
