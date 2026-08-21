#!/bin/bash
# download-rocky.sh — Download Rocky Linux container rootfs
set -e

echo "Downloading Rocky Linux..."
mkdir -p dist

VERSION=$(curl -sL "https://download.rockylinux.org/pub/rocky/" | grep -oP 'href="[0-9]+/' | sort -t. -k1,1n | tail -1 | grep -oP '[0-9]+')
if [ -z "$VERSION" ]; then
  VERSION="10"
fi
echo "Latest Rocky Linux: $VERSION"

curl -sL "https://download.rockylinux.org/pub/rocky/${VERSION}/images/aarch64/Rocky-${VERSION}-Container-Minimal.latest.aarch64.tar.xz" -o "dist/rocky-${VERSION}-aarch64.tar.xz"

echo "Done: dist/rocky-${VERSION}-aarch64.tar.xz"

echo "{\"id\":\"rocky\",\"version\":\"${VERSION}\",\"codename\":\"\",\"fileName\":\"rocky-${VERSION}-aarch64.tar.xz\"}" >> dist/metadata.jsonl
