#!/bin/bash

set -e
set -x

# sync rom
repo init --depth=1 -u https://github.com/CherishOS/android_manifest.git -b eleven
git clone https://github.com/sasukeuchiha-clan/Begonia --depth 1 -b CherishOS .repo/local_manifests
repo sync -c --no-clone-bundle --no-tags --optimized-fetch --prune --force-sync -j$(nproc --all)

# build rom
source build/envsetup.sh
lunch cherish_begonia-userdebug
mka bacon -j$(nproc --all)

# upload rom
up(){
	curl --upload-file $1 https://transfer.sh/$(basename $1); echo
	# 14 days, 10 GB limit
}

up out/target/product/begonia/*.zip
