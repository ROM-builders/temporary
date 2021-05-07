#!/bin/bash

set -exv

# Sync Rom

echo -e "Syncing PixelExperience"
repo init -u git://github.com/PixelExperience/manifest.git -b eleven-plus --depth=1
repo sync -c --no-clone-bundle --no-tags --optimized-fetch --prune --force-sync -j$(nproc --all)

# Setup vt,kt,dt and hals.

echo -e "Setup envorviment (git clone)"
git clone https://github.com/sushmit1/device_xiaomi_ysl -b aosp device/xiaomi/ysl --depth 1
git clone https://github.com/sushmit1/android_vendor_xiaomi_ysl -b r11.0 vendor/xiaomi/ysl --depth 1
git clone https://github.com/DhruvChhura/kernel-perf kernel/xiaomi/ysl --depth 1
rm -rf vendor/codeaurora/telephony hardware/qcom-caf/msm8996/media hardware/qcom-caf/msm8996/audio hardware/qcom-caf/msm8996/display && git clone https://github.com/wave-project/vendor_codeaurora_telephony --depth=1 --single-branch vendor/codeaurora/telephony/ && git clone --single-branch https://github.com/Jabiyeff/android_hardware_qcom_media hardware/qcom-caf/msm8996/media && git clone --single-branch https://github.com/Jabiyeff/android_hardware_qcom_display hardware/qcom-caf/msm8996/display &&  git clone https://github.com/LineageOS/android_hardware_qcom_audio --single-branch -b lineage-18.1-caf-msm8996 hardware/qcom-caf/msm8996/audio
