#!/bin/bash
# download-ubuntu.sh — Download Ubuntu rootfs from Docker Hub
set -e

echo "Downloading Ubuntu..."
mkdir -p dist

docker pull ubuntu:25.10
docker create --name ubuntu ubuntu:25.10
docker export ubuntu -o dist/ubuntu-aarch64.tar
docker rm ubuntu
xz -9 dist/ubuntu-aarch64.tar

echo "Done: dist/ubuntu-aarch64.tar.xz"
