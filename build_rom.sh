#!/bin/bash

set -e
set -x

# sync rom
repo init --depth=1 -u https://github.com/StyxProject/manifest -b R
repo sync -c -j$(nproc --all) --force-sync --no-clone-bundle --no-tags

#Setup
git clone https://github.com/arulebin/device_xiaomi_rosy.git -b styx device/xiaomi/rosy
git clone https://github.com/arulebin/vendor_xiaomi_rosy.git vendor/xiaomi/rosy
git clone https://github.com/arulebin/kernel_xiaomi_rosy.git kernel/xiaomi/rosy
rm -rf hardware/qcom-caf/msm8996

# build rom
source build/envsetup.sh
lunch styx_rosy-user
m styx-ota -j$(nproc --all)

# upload rom
up(){
	curl --upload-file $1 https://transfer.sh/$(basename $1); echo
	# 14 days, 10 GB limit
}

up out/target/product/rosy/*.zip

