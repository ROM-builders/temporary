#!/bin/bash

set -e
set -x

# sync rom
repo init --depth=1 -u https://github.com/PixelPlusUI-Elle/manifest -b eleven
git clone https://github.com/asus-tree-4-19/local_manifests.git --depth 1 -b main .repo/local_manifests
repo sync -c --no-clone-bundle --no-tags --optimized-fetch --prune --force-sync -j$(nproc --all)

# build rom
. build/envsetup.sh
lunch aosp_X00T-userdebug

mka bacon -j$(nproc --all)

# upload rom
up(){
	curl --upload-file $1 https://transfer.sh/$(basename $1); echo
	# 14 days, 10 GB limit
}

up out/target/product/X00T/*.zip
