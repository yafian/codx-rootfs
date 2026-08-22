#!/bin/bash
# download-opensuse.sh — Download openSUSE Leap rootfs from Docker Hub
set -e

echo "Downloading openSUSE Leap..."
mkdir -p dist

VERSION=$(curl -sL "https://download.opensuse.org/distribution/leap/" | grep -oP 'href="\./([0-9]+\.[0-9]+)/' | grep -oP '[0-9]+\.[0-9]+' | sort -t. -k1,1n -k2,2n | tail -1 || true)
if [ -z "$VERSION" ]; then
  VERSION="16.1"
fi
echo "Latest openSUSE: $VERSION"

sudo docker pull opensuse/leap:${VERSION}
sudo docker create --name opensuse opensuse/leap:${VERSION}
sudo docker export opensuse -o "dist/opensuse-leap-${VERSION}-aarch64.tar"
sudo docker rm opensuse
sudo chown $(id -u):$(id -g) "dist/opensuse-leap-${VERSION}-aarch64.tar"
xz -9 "dist/opensuse-leap-${VERSION}-aarch64.tar"

echo "Done: dist/opensuse-leap-${VERSION}-aarch64.tar.xz"

echo "{\"id\":\"opensuse\",\"version\":\"${VERSION}\",\"codename\":\"Leap\",\"fileName\":\"opensuse-leap-${VERSION}-aarch64.tar.xz\"}" >> dist/metadata.jsonl
