#!/bin/bash

set -exv

# sync rom
repo init -u https://github.com/Project-Fluid/manifest.git -b fluid-11 --depth=1
repo sync -c --no-clone-bundle --no-tags --optimized-fetch --prune --force-sync -j$(nproc --all)
echo finished sync

# Setup
git clone https://github.com/adrian-8901/device_xiaomi_umi.git -b fluid device/xiaomi/umi --depth=1
git clone https://github.com/adrian-8901/device_xiaomi_sm8250-common.git -b fluid device/xiaomi/sm8250-common --depth=1
git clone https://github.com/dataoutputstream/vendor_xiaomi_sm8250.git -b fluid vendor/xiaomi/sm8250-common --depth=1
git clone https://github.com/xiaomi-sm8250-devs/android_kernel_xiaomi_sm8250.git -b lineage-18.1 kernel/xiaomi/sm8250-common --depth=1
