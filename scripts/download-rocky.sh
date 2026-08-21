#!/bin/bash
# download-rocky.sh — Download Rocky Linux container rootfs
set -e

echo "Downloading Rocky Linux..."
mkdir -p dist

VERSION="10"

curl -sL "https://download.rockylinux.org/pub/rocky/${VERSION}/images/aarch64/Rocky-${VERSION}-Container-Minimal.latest.aarch64.tar.xz" -o "dist/rocky-${VERSION}-aarch64.tar.xz"

echo "Done: dist/rocky-${VERSION}-aarch64.tar.xz"
