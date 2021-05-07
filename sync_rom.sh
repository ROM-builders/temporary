#!/bin/bash

set -exv

# Sync Rom
repo init -u --depth=1 https://github.com/StyxProject/manifest -b R
repo sync -c --no-clone-bundle --no-tags --optimized-fetch --prune --force-sync -j$(nproc --all)

# Setup vt,kt,dt and hals.
git clone https://github.com/StyxProject-Devices/device_xiaomi_rosy.git -b R device/xiaomi/rosy --depth 1
git clone https://github.com/arulebin/vendor_xiaomi_rosy  vendor/xiaomi/rosy --depth 1
git clone https://github.com/arulebin/kernel_xiaomi_rosy --depth=1 kernel/xiaomi/rosy
rm -rf hardware/qcom-caf/msm8996 && git clone --single-branch https://github.com/Jabiyeff/android_hardware_qcom_media hardware/qcom-caf/msm8996-rosy/media && git clone --single-branch https://github.com/Jabiyeff/android_hardware_qcom_display hardware/qcom-caf/msm8996-rosy/display &&  git clone https://github.com/LineageOS/android_hardware_qcom_audio --single-branch -b lineage-18.1-caf-msm8996 hardware/qcom-caf/msm8996-rosy/audio
