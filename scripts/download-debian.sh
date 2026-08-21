#!/bin/bash
# download-debian.sh — Download Debian rootfs from Docker Hub
set -e

echo "Downloading Debian..."
mkdir -p dist

VERSION="trixie"

docker pull debian:${VERSION}
docker create --name debian debian:${VERSION}
docker export debian -o "dist/debian-${VERSION}-aarch64.tar"
docker rm debian
xz -9 "dist/debian-${VERSION}-aarch64.tar"

echo "Done: dist/debian-${VERSION}-aarch64.tar.xz"
