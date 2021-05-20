#!/bin/bash

# Sources
repo init -u https://github.com/NusantaraProject-ROM/android_manifest.git -b 11 --groups=all,-notdefault,-darwin,-mips,-device --depth=1
git clone https://github.com/hadad/android_repo_local_manifest.git .repo/local_manifests --depth=1
repo sync -c --no-clone-bundle --no-tags --optimized-fetch --prune --force-sync -j$(nproc --all)
repo sync -c --no-clone-bundle --no-tags --optimized-fetch --prune --force-sync -j8

# Build
source build/envsetup.sh
lunch nad_onclite-userdebug
mka nad -j$(nproc --all)

# Upload
curl --upload-file out/target/product/onclite/Nusantara_v2.9-11-onclite*.zip https://transfer.sh
