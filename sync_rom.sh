#!/bin/bash

set -exv

# sync rom
repo init -u  git://github.com/AOSiP/platform_manifest.git -b eleven --depth=1
git clone https://github.com/flashokiller/android_.repo_local_manifests --depth1  .repo/local_manifetsts -b aex
repo sync --force-sync --no-tags --no-clone-bundle
#Setup
# fix
rm -rf device/generic/opengl-transport
rm  -rf vendor/codeaurora/telephony hardware/qcom-caf/msm8996/media hardware/qcom-caf/msm8996/audio hardware/qcom-caf/msm8996/display && git clone https://github.com/wave-project/vendor_codeaurora_telephony --depth=1 --single-branch vendor/codeaurora/telephony/ && git clone --single-branch https://github.com/Jabiyeff/android_hardware_qcom_media hardware/qcom-caf/msm8996/media && git clone --single-branch https://github.com/Jabiyeff/android_hardware_qcom_display hardware/qcom-caf/msm8996/display &&  git clone https://github.com/LineageOS/android_hardware_qcom_audio --single-branch -b lineage-18.1-caf-msm8996 hardware/qcom-caf/msm8996/audio
cd device/xiaomi/ysl
rm -rf overlay/packages/services/Telephony/res/xml/telephony_injection.xml
cd ../../../
cd vendor/xiaomi/ysl
rm -rf msm8953-common/proprietary/system_ext/framework/qti-telephony-common.jar
cd ../../../
