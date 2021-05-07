#!/bin/bash

set -exv

# Sync ROM source
repo init -u git://github.com/LineageOS/android.git -b lineage-18.1 --depth=1
repo sync -j16 --optimized-fetch --no-tags --no-clone-bundle --force-sync

# Clone DT, VT, kernel and more needed stuff
git clone --depth=1 https://github.com/LinkBoi00/vendor_xiaomi_daisy-eleven vendor/xiaomi --depth 1
git clone --depth=1 https://github.com/LinkBoi00/device_xiaomi_daisy-eleven device/xiaomi/daisy --depth 1
git clone --depth=1 https://github.com/Couchpotato-sauce/kernel_xiaomi_sleepy kernel/xiaomi/msm8953 --depth 1
git clone https://github.com/kdrag0n/proton-clang --depth=1 prebuilts/clang/host/linux-x86/clang-proton --depth 1
rm -rf hardware/qcom-caf/msm8996/media hardware/qcom-caf/msm8996/audio hardware/qcom-caf/msm8996/display && git clone --single-branch https://github.com/Jabiyeff/android_hardware_qcom_media hardware/qcom-caf/msm8996/media && git clone --single-branch https://github.com/Jabiyeff/android_hardware_qcom_display hardware/qcom-caf/msm8996/display &&  git clone https://github.com/ItsVixano/android_hardware_qcom_audio --single-branch hardware/qcom-caf/msm8996/audio
