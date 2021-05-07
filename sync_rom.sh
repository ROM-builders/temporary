#!/bin/bash

set -exv

# sync rom
repo init -u git://github.com/AOSiP/platform_manifest.git -b eleven --depth=1
repo sync -c -j$(nproc --all) --force-sync --no-clone-bundle --no-tags
nproc --all
#Setup
git clone https://github.com/flashokiller/android_device_xiaomi_ysl device/xiaomi/ysl --depth 1
git clone https://github.com/ItsVixano/android_vendor_xiaomi_ysl vendor/xiaomi/ysl --depth 1
git clone https://github.com/flashokiller/flasho_Ysl kernel/xiaomi/ysl --depth 1
# fix
rm  -rf vendor/codeaurora/telephony hardware/qcom-caf/msm8996/media hardware/qcom-caf/msm8996/audio hardware/qcom-caf/msm8996/display && git clone https://github.com/wave-project/vendor_codeaurora_telephony --depth=1 --single-branch vendor/codeaurora/telephony/ && git clone --single-branch https://github.com/Jabiyeff/android_hardware_qcom_media hardware/qcom-caf/msm8996/media && git clone --single-branch https://github.com/Jabiyeff/android_hardware_qcom_display hardware/qcom-caf/msm8996/display &&  git clone https://github.com/LineageOS/android_hardware_qcom_audio --single-branch -b lineage-18.1-caf-msm8996 hardware/qcom-caf/msm8996/audio
cd device/xiaomi/ysl
rm -rf overlay/packages/services/Telephony/res/xml/telephony_injection.xml
cd ../../../
cd vendor/xiaomi/ysl
rm -rf msm8953-common/proprietary/system_ext/framework/qti-telephony-common.jar
cd ../../../
