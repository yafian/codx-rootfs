#!/bin/bash
# download-manjaro.sh — Download Manjaro ARM rootfs (proot-minimal)
set -e

echo "Downloading Manjaro ARM..."
mkdir -p dist rootfs

VERSION=$(curl -sL --connect-timeout 30 --max-time 60 \
  -H "Authorization: token $GITHUB_TOKEN" \
  "https://api.github.com/repos/manjaro-arm/rootfs/releases/latest" 2>/dev/null \
  | python3 -c "import sys,json; d=json.load(sys.stdin); print(d.get('tag_name',''))" 2>/dev/null || true)

if [ -z "$VERSION" ]; then
  VERSION=$(curl -sL "https://api.github.com/repos/manjaro-arm/rootfs/releases/latest" | python3 -c "import sys,json; print(json.load(sys.stdin)['tag_name'])" 2>/dev/null || echo "")
fi

if [ -z "$VERSION" ]; then
  echo "ERROR: Could not determine Manjaro version"
  exit 1
fi
echo "Latest Manjaro: $VERSION"

curl -fsSL --connect-timeout 30 --max-time 1800 \
  "https://github.com/manjaro-arm/rootfs/releases/download/${VERSION}/Manjaro-ARM-aarch64-latest.tar.gz" \
  -o manjaro.tar.gz

sudo tar -xzf manjaro.tar.gz -C rootfs || true
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
