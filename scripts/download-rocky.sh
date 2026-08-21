#!/bin/bash
# download-rocky.sh — Download Rocky Linux container rootfs
set -e

echo "Downloading Rocky Linux..."
mkdir -p dist

# Download container minimal
curl -sL "https://download.rockylinux.org/pub/rocky/10/images/aarch64/Rocky-10-Container-Minimal.latest.aarch64.tar.xz" -o dist/rocky-aarch64.tar.xz

echo "Done: dist/rocky-aarch64.tar.xz"
