#!/bin/bash
# download-void.sh — Download Void Linux ROOTFS
set -e

echo "Downloading Void Linux..."
mkdir -p dist

# Find latest date that has ROOTFS files
for DATE in $(curl -sL "https://repo-default.voidlinux.org/live/" | grep -oP '[0-9]{8}' | sort -r); do
  if curl -sI "https://repo-default.voidlinux.org/live/${DATE}/void-aarch64-ROOTFS-${DATE}.tar.xz" | grep -q "200 OK"; then
    VERSION=$DATE
    break
  fi
done

if [ -z "$VERSION" ]; then
  echo "No Void Linux ROOTFS found"
  exit 1
fi

echo "Latest Void: $VERSION"

curl -sL "https://repo-default.voidlinux.org/live/${VERSION}/void-aarch64-ROOTFS-${VERSION}.tar.xz" -o "dist/void-${VERSION}-aarch64.tar.xz"

ls -lh "dist/void-${VERSION}-aarch64.tar.xz"
echo "Done: dist/void-${VERSION}-aarch64.tar.xz"

echo "{\"id\":\"void\",\"version\":\"${VERSION}\",\"codename\":\"\",\"fileName\":\"void-${VERSION}-aarch64.tar.xz\"}" >> dist/metadata.jsonl
