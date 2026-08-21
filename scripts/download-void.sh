#!/bin/bash
# download-void.sh — Download Void Linux ROOTFS from official repo
set -e

echo "Downloading Void Linux..."
mkdir -p dist

# Get latest release date
DATE=$(curl -sL "https://repo-default.voidlinux.org/live/" | grep -oP '[0-9]{8}' | sort -r | head -1)
echo "Latest Void: $DATE"

# Download
curl -sL "https://repo-default.voidlinux.org/live/${DATE}/void-aarch64-ROOTFS-${DATE}.tar.xz" -o dist/void-aarch64.tar.xz

echo "Done: dist/void-aarch64.tar.xz"
