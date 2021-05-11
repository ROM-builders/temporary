#!/bin/bash

# sync rom
repo init --depth=1 -u git://github.com/LineageOS/android.git -b lineage-18.1 -g default,-device,-mips,-darwin,-notdefault
git clone https://github.com/ZunayedDihan/hotorou_manifest --depth 1 -b eleven .repo/local_manifests --depth=1
repo sync -c --no-clone-bundle --no-tags --optimized-fetch --prune --force-sync -j$(nproc --all)

# build rom
source build/envsetup.sh
lunch lineage_daisy-userdebug
mka bacon -j10

# upload rom
set -exv

# Upload ROM
upload(){
	curl --upload-file $1 https://transfer.sh/$(basename $1); echo
	# 14 days, 10 GB limit
}

upload out/target/product/daisy/*.zip
