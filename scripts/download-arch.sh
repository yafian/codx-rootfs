#!/bin/bash
# download-arch.sh — Download Arch Linux ARM rootfs
set -e

echo "Downloading Arch Linux ARM..."
mkdir -p dist

curl -sL "http://os.archlinuxarm.org/os/ArchLinuxARM-aarch64-latest.tar.gz" -o arch.tar.gz

# Recompress .tar.gz → .tar.xz without extracting (avoids symlink issues)
gunzip -c arch.tar.gz | tar -cf dist/archlinux-aarch64.tar --no-recursion -T - 2>/dev/null || \
  gunzip -c arch.tar.gz | tar -cf dist/archlinux-aarch64.tar -
xz -9 dist/archlinux-aarch64.tar
rm -f arch.tar.gz

echo "Done: dist/archlinux-aarch64.tar.xz"
