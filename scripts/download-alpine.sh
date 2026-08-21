#!/bin/bash
# download-alpine.sh — Download Alpine rootfs from official CDN
set -e

echo "Downloading Alpine Linux..."
mkdir -p dist

FILE=$(curl -sL "https://dl-cdn.alpinelinux.org/alpine/latest-stable/releases/aarch64/latest-releases.yaml" | grep "file: alpine-minirootfs" | head -1 | awk '{print $2}')
VERSION=$(echo "$FILE" | grep -oP '[0-9]+\.[0-9]+\.[0-9]+')
BRANCH="${VERSION%.*}"
echo "Latest Alpine: $VERSION"

curl -sL "https://dl-cdn.alpinelinux.org/alpine/v${BRANCH}/releases/aarch64/${FILE}" -o alpine.tar.gz

mkdir -p rootfs
tar -xzf alpine.tar.gz -C rootfs
cd rootfs && tar -cf "../dist/alpine-${VERSION}-aarch64.tar" . && cd ..
xz -9 "dist/alpine-${VERSION}-aarch64.tar"
rm -rf alpine.tar.gz rootfs

echo "Done: dist/alpine-${VERSION}-aarch64.tar.xz"

echo "{\"id\":\"alpine\",\"version\":\"${VERSION}\",\"codename\":\"\",\"fileName\":\"alpine-${VERSION}-aarch64.tar.xz\"}" >> dist/metadata.jsonl
