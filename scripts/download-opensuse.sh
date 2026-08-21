#!/bin/bash
# download-opensuse.sh — Download openSUSE Leap rootfs from Docker Hub
set -e

echo "Downloading openSUSE Leap..."
mkdir -p dist

# Get latest version
VERSION=$(curl -sL "https://download.opensuse.org/distribution/leap/" | grep -oP 'href="[0-9]+\.[0-9]+"' | tail -1 | grep -oP '[0-9]+\.[0-9]+')
echo "Latest openSUSE: $VERSION"

# Pull and export Docker image
docker pull opensuse/leap:${VERSION}
docker create --name opensuse opensuse/leap:${VERSION}
docker export opensuse | tar -xf - -C dist --strip-components=0
docker rm opensuse

# Repackage as .tar.xz
cd dist && tar -cf opensuse-aarch64.tar . && cd ..
xz -9 dist/opensuse-aarch64.tar
rm -f dist/opensuse-aarch64.tar

echo "Done: dist/opensuse-aarch64.tar.xz"
