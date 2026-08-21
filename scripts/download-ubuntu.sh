#!/bin/bash
# download-ubuntu.sh — Download Ubuntu rootfs from Docker Hub
set -e

echo "Downloading Ubuntu..."
mkdir -p dist

VERSION=$(curl -sL "https://cdimage.ubuntu.com/ubuntu-base/releases/" | grep -oP 'href="[0-9]+\.[0-9]+/' | sort -t. -k1,1n -k2,2n | tail -1 | grep -oP '[0-9]+\.[0-9]+')
echo "Latest Ubuntu: $VERSION"

docker pull ubuntu:${VERSION}
docker create --name ubuntu ubuntu:${VERSION}
docker export ubuntu -o "dist/ubuntu-${VERSION}-aarch64.tar"
docker rm ubuntu
xz -9 "dist/ubuntu-${VERSION}-aarch64.tar"

echo "Done: dist/ubuntu-${VERSION}-aarch64.tar.xz"
