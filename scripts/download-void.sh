#!/bin/bash
# download-void.sh — Download Void Linux aarch64 rootfs
set -e

echo "Downloading Void Linux..."

# Find latest ROOTFS from official Void Linux live directory
LATEST=$(curl -sL "https://repo-default.voidlinux.org/live/" | grep -oP 'href="void-aarch64-ROOTFS-[0-9]+\.tar\.xz"' | grep -oP '[0-9]+' | sort -n | tail -1)
if [ -z "$LATEST" ]; then
  echo "ERROR: Could not determine latest Void ROOTFS version"
  exit 1
fi
echo "Latest Void ROOTFS: $LATEST"

mkdir -p dist rootfs

curl -fsSL --connect-timeout 30 --max-time 1800 \
  "https://repo-default.voidlinux.org/live/void-aarch64-ROOTFS-${LATEST}.tar.xz" \
  -o void-rootfs.tar.xz

tar -xJf void-rootfs.tar.xz -C rootfs
sudo chown -R $(id -u):$(id -g) rootfs

cd rootfs
tar -cf "../dist/void-linux-${LATEST}-aarch64.tar" .
cd ..
xz -9 "dist/void-linux-${LATEST}-aarch64.tar"
rm -rf void-rootfs.tar.xz rootfs

ls -lh "dist/void-linux-${LATEST}-aarch64.tar.xz"
echo "Done"

echo "{\"id\":\"void\",\"version\":\"${LATEST}\",\"codename\":\"\",\"fileName\":\"void-linux-${LATEST}-aarch64.tar.xz\"}" >> dist/metadata.jsonl
