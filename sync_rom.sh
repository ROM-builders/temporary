#!/bin/bash

set -exv

# sync rom
repo init -u  git://github.com/AOSiP/platform_manifest.git -b eleven --depth=1





git clone  https://github.com/flashokiller/mainfest_personal --depth=1  .repo/local_manifests -b master
repo sync --force-sync --no-tags --no-clone-bundle



#huls
rm  -rf vendor/codeaurora/telephony hardware/qcom-caf/msm8996/media hardware/qcom-caf/msm8996/audio hardware/qcom-caf/msm8996/display && git clone https://github.com/wave-project/vendor_codeaurora_telephony --depth=1 --single-branch vendor/codeaurora/telephony/ && git clone --single-branch https://github.com/Jabiyeff/android_hardware_qcom_media hardware/qcom-caf/msm8996-ysl/media && git clone --single-branch https://github.com/Jabiyeff/android_hardware_qcom_display hardware/qcom-caf/msm8996-ysl/display &&  git clone https://github.com/LineageOS/android_hardware_qcom_audio --single-branch -b lineage-18.1-caf-msm8996 hardware/qcom-caf/msm8996-ysl/audio
