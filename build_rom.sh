#!/bin/bash

set -e
set -x

sudo apt install wget -y

rm -rf .repo/local_manifests

# sync rom
repo init -u git://github.com/LineageOS/android.git -b lineage-18.1

git clone https://github.com/cArN4gEisDeD/local_manifest

repo sync -c --no-clone-bundle --no-tags --optimized-fetch --prune --force-sync -j$(nproc --all)

# build
. build/envsetup.sh
lunch lineage_RMX1941-userdebug
mka bacon -j$(nproc --all)

# upload rom
up(){
        curl --upload-file $1 https://transfer.sh/$(basename $1); echo
        # 14 days, 10 GB limit
}

up out/target/product/RMX1941/*.zip
