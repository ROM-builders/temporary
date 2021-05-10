#!/bin/bash

set -e
set -x

# sync rom
repo init --depth=1 -u git://github.com/CipherOS/android_manifest.git -b eleven

git clone https://github.com/whtisusername/frostmanifest.git --depth=1 -b derp .repo/local_manifests

repo sync -c --no-clone-bundle --no-tags --optimized-fetch --prune --force-sync -j$(nproc --all)


# build rom
source build/envsetup.sh
export CIPHER_OFFICIAL=true
export CIPHER_GAPPS=true
lunch lineage_lavender-userdebug
make bacon

# upload rom
up(){
	curl --upload-file $1 https://transfer.sh/$(basename $1); echo
	# 14 days, 10 GB limit
}

up out/target/product/lavender/*.zip
