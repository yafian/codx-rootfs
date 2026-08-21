#!/bin/bash
# download-debian.sh — Download Debian rootfs from Docker Hub
set -e

echo "Downloading Debian..."
mkdir -p dist

docker pull debian:trixie
docker create --name debian debian:trixie
docker export debian -o dist/debian-aarch64.tar
docker rm debian
xz -9 dist/debian-aarch64.tar

echo "Done: dist/debian-aarch64.tar.xz"
