#!/bin/bash

set -e
set -x

# sync rom
repo init --depth=1 https://github.com/PotatoProject/manifest -b dumaloo-release
repo sync -c --no-clone-bundle --no-tags --optimized-fetch --prune --force-sync -j$(nproc --all)

#clone
git clone --depth=1 https://github.com/devil-black-786/octavi_oppo_CPH1859 -b posp device/oppo/CPH1859
git clone --depth=1 https://github.com/CPH1859/proprietary_vendor_oppo_CPH1859 vendor/oppo/CPH1859

# build rom
source build/envsetup.sh
lunch potato_mido-userdebug
brunch CPH1859 -j$(nproc --all)

# upload rom
up(){
	curl --upload-file $1 https://transfer.sh/$(basename $1); echo
	# 14 days, 10 GB limit
}

up out/target/product/CPH1859/*.zip
