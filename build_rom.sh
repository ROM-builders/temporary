#!/bin/bash

# Source.

repo init -u git://github.com/DotOS/manifest.git -b dot11 --depth=1

repo sync --force-sync --no-tags --no-clone-bundle

# hals and trees
rm -rf vendor/codeaurora/telephony hardware/qcom-caf/msm8996/media hardware/qcom-caf/msm8996/audio hardware/qcom-caf/msm8996/display && git clone https://github.com/wave-project/vendor_codeaurora_telephony --depth=1 --single-branch vendor/codeaurora/telephony/ && git clone --single-branch https://github.com/Jabiyeff/android_hardware_qcom_media hardware/qcom-caf/msm8996/media && git clone --single-branch https://github.com/Jabiyeff/android_hardware_qcom_display hardware/qcom-caf/msm8996/display && git clone https://github.com/LineageOS/android_hardware_qcom_audio --single-branch -b lineage-18.1-caf-msm8996 hardware/qcom-caf/msm8996/audio && git clone https://github.com/MiDoNaSR545/android_device_xiaomi_ysl -b dotos --depth=1 device/xiaomi/ysl && git clone https://github.com/MiDoNaSR545/android_vendor_xiaomi_ysl -b r11.0 --depth=1 vendor/xiaomi/ysl && git clone https://github.com/stormbreaker-project/kernel_xiaomi_ysl.git --depth=1 -b eleven kernel/xiaomi/ysl

source build/envsetup.sh
lunch dot_ysl-user
make bacon

# upload rom
up(){
	curl --upload-file $1 https://transfer.sh/$(basename $1); echo
	# 14 days, 10 GB limit
}

up out/target/product/ysl/*.zip

