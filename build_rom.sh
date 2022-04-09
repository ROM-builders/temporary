# sync rom
repo init --depth=1 --no-repo-verify -u https://github.com/ArrowOS/android_manifest.git -b arrow-12.1 -g default,-mips,-darwin,-notdefault  
git clone https://github.com/jeno1712/local_manifest.git --depth 1 -b main .repo/local_manifests
repo sync -c --no-clone-bundle --no-tags --optimized-fetch --prune --force-sync -j8
rm -rf hardware/qcom-caf/msm8996
git clone https://github.com/LineageOS/android_hardware_qcom_display.git -b lineage-19.0-caf-msm8996 hardware/qcom-caf/msm8996/display
git clone https://github.com/LineageOS/android_hardware_qcom_audio.git -b lineage-19.0-caf-msm8996 hardware/qcom-caf/msm8996/audio
git clone https://github.com/LineageOS/android_hardware_qcom_media.git -b lineage-19.0-caf-msm8996 hardware/qcom-caf/msm8996/media

#build rom
source build/envsetup.sh
lunch arrow_X01AD-userdebug
export TZ=Asia/Kolkata #put before last build command
m bacon

# upload rom (if you don't need to upload multiple files, then you don't need to edit next line)
rclone copy out/target/product/$(grep unch $CIRRUS_WORKING_DIR/build_rom.sh -m 1 | cut -d ' ' -f 2 | cut -d _ -f 2 | cut -d - -f 1)/*.zip cirrus:$(grep unch $CIRRUS_WORKING_DIR/build_rom.sh -m 1 | cut -d ' ' -f 2 | cut -d _ -f 2 | cut -d - -f 1) -P
