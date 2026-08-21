#!/bin/bash
# download-ubuntu.sh — Download Ubuntu rootfs from Docker Hub
set -e

echo "Downloading Ubuntu..."
mkdir -p dist

VERSION="25.10"

docker pull ubuntu:${VERSION}
docker create --name ubuntu ubuntu:${VERSION}
docker export ubuntu -o "dist/ubuntu-${VERSION}-aarch64.tar"
docker rm ubuntu
xz -9 "dist/ubuntu-${VERSION}-aarch64.tar"

echo "Done: dist/ubuntu-${VERSION}-aarch64.tar.xz"
