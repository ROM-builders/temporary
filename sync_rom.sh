#!/bin/bash

set -exv

# sync rom
repo init --depth=1 -u https://github.com/Project-Fluid/manifest.git -b fluid-11
repo sync -c --no-clone-bundle --no-tags --optimized-fetch --prune --force-sync -j$(nproc --all)

# Setup
find hardware/ril/libril vendor/qcom/opensource/power .repo/ -delete
git clone https://github.com/NusantaraProject-ROM/android_vendor_qcom_opensource_power -b 11 vendor/qcom/opensource/power
git clone https://github.com/nnippon/android_hardware_samsung -b aosp --depth=1 hardware/samsung
git clone https://github.com/nnippon/android_device_samsung_j4primelte -b fluid --depth=1 device/samsung/j4primelte
git clone https://github.com/nnippon/android_vendor_samsung-common --depth=1 vendor/samsung
git clone https://github.com/nnippon/android_device_samsung_msm8917-common -b fluid --depth=1 device/samsung/msm8917-common
git clone https://github.com/nnippon/android_kernel_samsung_msm8917 --depth=1 kernel/samsung/msm8917
git clone https://github.com/lostark13/vendor_MiuiCamera --depth=1 vendor/MiuiCamera
