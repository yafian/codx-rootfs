#!/bin/bash
# download-opensuse.sh — Download openSUSE Leap rootfs from Docker Hub
set -e

echo "Downloading openSUSE Leap..."
mkdir -p dist

# Export Docker image as rootfs
docker pull opensuse/leap:16.0
docker create --name opensuse opensuse/leap:16.0
docker export opensuse -o dist/opensuse-aarch64.tar
docker rm opensuse
xz -9 dist/opensuse-aarch64.tar

echo "Done: dist/opensuse-aarch64.tar.xz"
