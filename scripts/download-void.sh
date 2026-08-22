#!/bin/bash
# download-void.sh — Download Void Linux aarch64 rootfs
set -e

echo "Downloading Void Linux..."
mkdir -p dist rootfs

# Find latest date dir that has an aarch64 ROOTFS
LATEST_DIR=""
for DIR in $(curl -sL "https://repo-default.voidlinux.org/live/" | grep -oP 'href="([0-9]+)/"' | grep -oP '[0-9]+' | sort -rn); do
  if curl -sL "https://repo-default.voidlinux.org/live/${DIR}/" | grep -q "void-aarch64-ROOTFS"; then
    LATEST_DIR="$DIR"
    break
  fi
done

if [ -z "$LATEST_DIR" ]; then
  echo "ERROR: Could not find Void aarch64 ROOTFS"
  exit 1
fi

FILENAME="void-aarch64-ROOTFS-${LATEST_DIR}.tar.xz"
echo "Latest Void ROOTFS: ${LATEST_DIR} (${FILENAME})"

curl -fsSL --connect-timeout 30 --max-time 1800 \
  "https://repo-default.voidlinux.org/live/${LATEST_DIR}/${FILENAME}" \
  -o void-rootfs.tar.xz

tar -xJf void-rootfs.tar.xz -C rootfs

cd rootfs
tar -cf "../dist/void-linux-${LATEST_DIR}-aarch64.tar" .
cd ..
xz -9 "dist/void-linux-${LATEST_DIR}-aarch64.tar"
rm -rf void-rootfs.tar.xz rootfs

ls -lh "dist/void-linux-${LATEST_DIR}-aarch64.tar.xz"
echo "Done"

echo "{\"id\":\"void\",\"version\":\"${LATEST_DIR}\",\"codename\":\"\",\"fileName\":\"void-linux-${LATEST_DIR}-aarch64.tar.xz\"}" >> dist/metadata.jsonl
