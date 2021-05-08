#!/bin/bash

set -exv

# sync rom
repo init -u git://github.com/ForkLineageOS/android.git --depth=1 -b lineage-18.1
git clone https://github.com/Realme-G70-Series/local_manifest.git --depth=1 .repo/local_manifests
repo sync -c --no-clone-bundle --no-tags --optimized-fetch --prune --force-sync -j$(nproc --all)
echo finished sync
cd external/selinux && wget https://raw.githubusercontent.com/SamarV-121/android_vendor_extra/lineage-18.1/patches/external/selinux/0001-Revert-libsepol-Make-an-unknown-permission-an-error-.patch && patch -p1 < *.patch
cd ../..
cd frameworks/av && wget https://github.com/phhusson/platform_frameworks_av/commit/624cfc90b8bedb024f289772960f3cd7072fa940.patch && patch -p1 < *.patch
cd ../..
echo finished patches
