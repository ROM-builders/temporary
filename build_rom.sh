# sync rom
repo init --depth=1 --no-repo-verify -u git://github.com/AospExtended/manifest.git -b 11 -g default,-device,-mips,-darwin,-notdefault
git clone https://github.com/STRK-ND/local-manifest.git --depth 1 -b main .repo/local_manifests
repo sync -c --no-clone-bundle --no-tags --optimized-fetch --prune --force-sync -j8

# cloning and removing repositories

rm -rf vendor/qcom/opensource/data-ipa-cfg-mgr

git clone https://github.com/LineageOS/android_vendor_qcom_opensource_data-ipa-cfg-mgr -b lineage-18.1 vendor/qcom/opensource/data-ipa-cfg-mgr

rm -rf hardware/qcom-caf/wlan

git clone https://github.com/LineageOS/android_hardware_qcom_wlan -b lineage-18.1-caf hardware/qcom-caf/wlan

rm -rf vendor/qcom/opensource/power

git clone https://github.com/pkm774/vendor_qcom_opensource_power -b power.legacyopensource.lnx.1.0.r15-rel vendor/qcom/opensource/power

rm -rf external/tinyalsa

git clone https://source.codeaurora.org/quic/la/platform/external/tinyalsa -b ks-aosp.lnx.3.0.r15-rel external/tinyalsa

rm -rf external/tinycompress

git clone https://github.com/pkm774/external_tinycompress -b ks-aosp.lnx.3.0.r15-rel external/tinycompress

rm -rf hardware/qcom-caf/msm8998/audio

git clone https://github.com/pkm774/hardware_qcom-caf_msm8998_audio -b audio-hal.lnx.8.0.r14-rel hardware/qcom-caf/msm8998/audio

rm -rf hardware/qcom-caf/msm8998/media

git clone https://github.com/pkm774/hardware_qcom-caf_media_msm8998 -b 11 hardware/qcom-caf/msm8998/media

rm -rf hardware/qcom-caf/msm8998/display

git clone https://github.com/pkm774/hardware_qcom-caf_display_msm8998 -b 11 hardware/qcom-caf/msm8998/display

rm -rf hardware/qcom-caf/thermal

git clone https://github.com/pkm774/android_hardware_qcom_thermal -b aosp-new/android11-qpr3-s1-release hardware/qcom-caf/thermal

rm -rf hardware/libhardware

git clone https://github.com/LineageOS/android_hardware_libhardware -b lineage-18.0 hardware/libhardware

# SnapdragonCamera

rm -rf packages/apps/Camera

git clone https://github.com/pkm774/packages_apps_SnapdragonCamera -b camera.lnx.3.2.r13-rel packages/apps/Camera

# Private repo vendor/sounds

rm -rf vendor/sounds

git clone https://github.com/pkm774/sounds vendor/sounds

# Remove pixel-charger resources from vendor

rm -rf vendor/descendant/charger

# build rom
source build/envsetup.sh
lunch aosp_X00TD-userdebug
export TZ=Asia/Dhaka #put before last build command
m aex

# upload rom (if you don't need to upload multiple files, then you don't need to edit next line)
rclone copy out/target/product/$(grep unch $CIRRUS_WORKING_DIR/build_rom.sh -m 1 | cut -d ' ' -f 2 | cut -d _ -f 2 | cut -d - -f 1)/*.zip cirrus:$(grep unch $CIRRUS_WORKING_DIR/build_rom.sh -m 1 | cut -d ' ' -f 2 | cut -d _ -f 2 | cut -d - -f 1) -P
