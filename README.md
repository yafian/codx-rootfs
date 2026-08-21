# CodX Rootfs Sync

Automated rootfs download from original upstream sources.

## What This Does

Downloads rootfs images directly from the same original sources where Conduit/TermX collects them:

| Distro | Source |
|---|---|
| Alpine | `dl-cdn.alpinelinux.org` |
| Arch Linux ARM | `os.archlinuxarm.org` |
| Debian | `deb.debian.org` |
| Ubuntu | `cdimage.ubuntu.com` |
| Rocky Linux | `download.rockylinux.org` |
| openSUSE | Docker Hub `opensuse/leap` |
| Void Linux | `repo-default.voidlinux.org` |
| Manjaro ARM | `github.com/manjaro-arm/rootfs` |

## How It Works

1. Every Monday, checks each upstream for new versions
2. Downloads the rootfs tarball
3. Repackages as `.tar.xz` (same format as Conduit)
4. Creates GitHub release with SHA256 checksums

## Usage

Push this repo to GitHub, enable Actions, and it runs automatically.

## Files

```
.github/workflows/sync-rootfs.yml
scripts/
├── download-alpine.sh
├── download-arch.sh
├── download-debian.sh
├── download-ubuntu.sh
├── download-rocky.sh
├── download-opensuse.sh
├── download-void.sh
└── download-manjaro.sh
```
