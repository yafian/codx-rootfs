#!/bin/bash
# download-void.sh — Download Void Linux ROOTFS
set -e

echo "Downloading Void Linux..."
mkdir -p dist

VERSION="20250202"
echo "Void Linux: $VERSION"

curl -sL "https://repo-default.voidlinux.org/live/${VERSION}/void-aarch64-ROOTFS-${VERSION}.tar.xz" -o "dist/void-${VERSION}-aarch64.tar.xz"

ls -lh "dist/void-${VERSION}-aarch64.tar.xz"
echo "Done: dist/void-${VERSION}-aarch64.tar.xz"
