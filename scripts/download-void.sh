#!/bin/bash
# download-void.sh — Download Void Linux ROOTFS
set -e

echo "Downloading Void Linux..."
mkdir -p dist

DATE=$(curl -sL "https://repo-default.voidlinux.org/live/" | grep -oP '[0-9]{8}' | sort -r | head -1)
echo "Latest Void: $DATE"

curl -sL "https://repo-default.voidlinux.org/live/${DATE}/void-aarch64-ROOTFS-${DATE}.tar.xz" -o "dist/void-${DATE}-aarch64.tar.xz"

echo "Done: dist/void-${DATE}-aarch64.tar.xz"
