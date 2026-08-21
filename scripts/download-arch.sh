#!/bin/bash
# download-arch.sh — Download Arch Linux ARM rootfs (proot-minimal)
set -e

echo "Downloading Arch Linux ARM..."
mkdir -p dist rootfs

VERSION=$(date +%Y%m%d)

curl -sL "http://os.archlinuxarm.org/os/ArchLinuxARM-aarch64-latest.tar.gz" -o arch.tar.gz

sudo tar -xzf arch.tar.gz -C rootfs 2>/dev/null

# Strip everything proot doesn't need (match Conduit's build)
sudo rm -rf \
  rootfs/boot/* \
  rootfs/usr/lib/modules/* \
  rootfs/usr/lib/firmware/* \
  rootfs/usr/share/doc/* \
  rootfs/usr/share/man/* \
  rootfs/usr/share/info/* \
  rootfs/usr/share/locale/* \
  rootfs/usr/share/i18n/* \
  rootfs/usr/share/gtk-doc/* \
  rootfs/usr/share/glib-2.0/* \
  rootfs/var/cache/pacman/* \
  rootfs/var/lib/pacman/local/*linux* \
  rootfs/var/lib/pacman/local/*firmware* \
  rootfs/usr/lib/systemd/system/*sleep* \
  rootfs/usr/lib/systemd/system/*suspend* \
  rootfs/usr/lib/systemd/system/*hibernate*

# Remove kernel and firmware package metadata
sudo rm -rf rootfs/var/lib/pacman/local/linux-aarch64*
sudo rm -rf rootfs/var/lib/pacman/local/linux-firmware*

sudo tar -cf "dist/archlinux-${VERSION}-aarch64.tar" -C rootfs .
xz -9 "dist/archlinux-${VERSION}-aarch64.tar"
sudo rm -rf arch.tar.gz rootfs

ls -lh "dist/archlinux-${VERSION}-aarch64.tar.xz"
echo "Done"
