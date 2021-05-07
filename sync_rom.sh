#!/bin/bash

set -exv

repo init --depth=1 -u https://github.com/PixelExperience/manifest -b eleven

repo sync --force-sync --no-tags --no-clone-bundle

# hals and trees
rm -rf vendor/codeaurora/telephony hardware/qcom-caf/msm8996/media hardware/qcom-caf/msm8996/audio hardware/qcom-caf/msm8996/display && git clone https://github.com/wave-project/vendor_codeaurora_telephony --depth=1 --single-branch vendor/codeaurora/telephony/ && git clone --single-branch https://github.com/Jabiyeff/android_hardware_qcom_media hardware/qcom-caf/msm8996/media && git clone --single-branch https://github.com/Jabiyeff/android_hardware_qcom_display hardware/qcom-caf/msm8996/display &&  git clone https://github.com/LineageOS/android_hardware_qcom_audio --single-branch -b lineage-18.1-caf-msm8996 hardware/qcom-caf/msm8996/audio && git clone --depth=1 https://github.com/DhruvChhura/android_device_xiaomi_ysl.git -b pe device/xiaomi/ysl && git clone --depth=1 https://github.com/DhruvChhura/android_vendor_xiaomi_ysl.git vendor/xiaomi/ysl && git clone --depth=1 https://github.com/DhruvChhura/kernel-perf.git kernel/xiaomi/ysl
