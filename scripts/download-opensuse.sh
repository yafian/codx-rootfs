#!/bin/bash
# download-opensuse.sh — Download openSUSE Leap rootfs from Docker Hub
set -e

echo "Downloading openSUSE Leap..."
mkdir -p dist

VERSION=$(curl -sL "https://download.opensuse.org/distribution/leap/" | grep -oP 'href="[0-9]+\.[0-9]+"' | tail -1 | grep -oP '[0-9]+\.[0-9]+')
if [ -z "$VERSION" ]; then
  VERSION="16.0"
fi
echo "Latest openSUSE: $VERSION"

docker pull opensuse/leap:${VERSION}
docker create --name opensuse opensuse/leap:${VERSION}
docker export opensuse -o "dist/opensuse-leap-${VERSION}-aarch64.tar"
docker rm opensuse
xz -9 "dist/opensuse-leap-${VERSION}-aarch64.tar"

echo "Done: dist/opensuse-leap-${VERSION}-aarch64.tar.xz"
