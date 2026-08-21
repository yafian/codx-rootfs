#!/bin/bash
# download-debian.sh — Download Debian rootfs from official mirrors
set -e

echo "Downloading Debian..."
mkdir -p dist

# Download trixie base from Debian mirrors
curl -sL "https://deb.debian.org/debian/dists/trixie/main/installer-arm64/current/images/netboot/debian-installer/arm64/rootfs.tar.xz" -o dist/debian-aarch64.tar.xz

echo "Done: dist/debian-aarch64.tar.xz"
