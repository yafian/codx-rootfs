#!/bin/bash
# download-opensuse.sh — Download openSUSE Leap rootfs
set -e

echo "Downloading openSUSE Leap..."
mkdir -p dist

VERSION=$(curl -sL "https://download.opensuse.org/distribution/leap/" | grep -oP 'href="[0-9]+\.[0-9]+"' | tail -1 | grep -oP '[0-9]+\.[0-9]+')
if [ -z "$VERSION" ]; then
  VERSION="16.0"
fi
echo "Latest openSUSE: $VERSION"

curl -sL "https://download.opensuse.org/distribution/leap/${VERSION}/appliances/opensuse-leap-image.aarch64-networkd.tar.xz" -o dist/opensuse-aarch64.tar.xz

echo "Done: dist/opensuse-aarch64.tar.xz"
