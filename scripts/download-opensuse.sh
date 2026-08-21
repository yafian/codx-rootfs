#!/bin/bash
# download-opensuse.sh — Download openSUSE Leap rootfs from Docker Hub
set -e

echo "Downloading openSUSE Leap..."
mkdir -p dist

VERSION="16.0"

docker pull opensuse/leap:${VERSION}
docker create --name opensuse opensuse/leap:${VERSION}
docker export opensuse -o "dist/opensuse-leap-${VERSION}-aarch64.tar"
docker rm opensuse
xz -9 "dist/opensuse-leap-${VERSION}-aarch64.tar"

echo "Done: dist/opensuse-leap-${VERSION}-aarch64.tar.xz"
