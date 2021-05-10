#!/bin/bash

set -e
set -x

# sync rom
repo init -u git://github.com/crdroidandroid/android.git --depth=1 -b 11.0
git clone https://github.com/boedhack/local_manifest.git -b 11.0 --depth=1 .repo/local_manifests
repo sync -c --no-clone-bundle --no-tags --optimized-fetch --prune --force-sync -j$(nproc --all)

# build rom
source build/envsetup.sh
lunch lineage_mojito-user
export SKIP_API_CHECKS=true
export SKIP_ABI_CHECKS=true
mka bacon -j$(nproc --all)

# upload rom
up(){
	curl --upload-file $1 https://transfer.sh/$(basename $1); echo
	# 14 days, 10 GB limit
}

up out/target/product/mojito/*-Unofficial-test.zip
