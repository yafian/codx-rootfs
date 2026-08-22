#!/bin/bash
# download-opensuse.sh — Download openSUSE Leap rootfs from Docker Hub
set -e

echo "Downloading openSUSE Leap..."
mkdir -p dist

VERSION=$(curl -sL "https://hub.docker.com/v2/repositories/opensuse/leap/tags?page_size=100&ordering=last_updated" | python3 -c "
import sys, json
data = json.load(sys.stdin)
versions = []
for r in data['results']:
    name = r['name']
    parts = name.split('.')
    if len(parts) == 2 and parts[0].isdigit() and parts[1].isdigit():
        major = int(parts[0])
        minor = int(parts[1])
        if 15 <= major < 40:
            versions.append((major, minor, name))
versions.sort()
if versions:
    print(versions[-1][2])
" || true)
if [ -z "$VERSION" ]; then
  VERSION="16.0"
fi
echo "Latest openSUSE: $VERSION"

sudo docker pull opensuse/leap:${VERSION}
sudo docker create --name opensuse opensuse/leap:${VERSION}
sudo docker export opensuse | sudo tee "dist/opensuse-leap-${VERSION}-aarch64.tar" > /dev/null
sudo docker rm opensuse
sudo chown $(id -u):$(id -g) "dist/opensuse-leap-${VERSION}-aarch64.tar"
xz -9 "dist/opensuse-leap-${VERSION}-aarch64.tar"

echo "Done: dist/opensuse-leap-${VERSION}-aarch64.tar.xz"

echo "{\"id\":\"opensuse\",\"version\":\"${VERSION}\",\"codename\":\"Leap\",\"fileName\":\"opensuse-leap-${VERSION}-aarch64.tar.xz\"}" >> dist/metadata.jsonl
