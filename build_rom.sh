#!/bin/bash

set -exv

# sync rom
repo init -u  git://github.com/crdroidandroid/android.git -b 11.0 --depth=1
git clone https://github.com/flashokiller/mainfest_presonal--depth=1  .repo/local_manifests -b aex
repo sync --force-sync --no-tags --no-clone-bundle

#huls
rm  -rf vendor/codeaurora/telephony hardware/qcom-caf/msm8996-ysl/media hardware/qcom-caf/msm8996-ysl/audio hardware/qcom-caf/msm8996-ysl/display && git clone https://github.com/wave-project/vendor_codeaurora_telephony --depth=1 --single-branch vendor/codeaurora/telephony/ && git clone --single-branch https://github.com/Jabiyeff/android_hardware_qcom_media hardware/qcom-caf/msm8996-ysl/media && git clone --single-branch https://github.com/Jabiyeff/android_hardware_qcom_display hardware/qcom-caf/msm8996-ysl/display &&  git clone https://github.com/LineageOS/android_hardware_qcom_audio --single-branch -b lineage-18.1-caf-msm8996 hardware/qcom-caf/msm8996-ysl/audio

#uild rom
. build/envsetup.sh
lunch aosip_ysl-userdebug
time m kronic
