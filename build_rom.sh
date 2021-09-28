# sync rom
repo init --depth=1 --no-repo-verify -u git://github.com/CherishOS/android_manifest.git -b eleven -g default,-device,-mips,-darwin,-notdefault
git clone https://github.com/RishikRastogi/Local-Manifests.git --depth 1 -b master .repo/local_manifests
repo sync -c --no-clone-bundle --no-tags --optimized-fetch --prune --force-sync -j8
# git clone https://github.com/syberia-project/platform_hardware_qcom_media.git --depth=1 -b 11.0-caf-sdm845 hardware/qcom-caf/sdm845/media
# git clone https://github.com/syberia-project/platform_hardware_qcom_audio.git --depth=1 -b 11.0-caf-sdm845 hardware/qcom-caf/sdm845/audio
# git clone https://github.com/syberia-project/platform_hardware_qcom_display.git --depth=1 -b 11.0-caf-sdm845 hardware/qcom-caf/sdm845/display

# git clone https://github.com/RishikRastogi/platform_frameworks_av.git --depth=1 -b 11.0 frameworks/av

# build rom
source build/envsetup.sh
lunch cherish_Z01R-userdebug
export SKIP_ABI_CHECKS=true
export WITH_GMS:=true
export TZ=Asia/Kolkata #put before last build command
brunch cherish_Z01R-userdebug

# upload rom (if you don't need to upload multiple files, then you don't need to edit next line)
rclone copy out/target/product/$(grep unch $CIRRUS_WORKING_DIR/build_rom.sh -m 1 | cut -d ' ' -f 2 | cut -d _ -f 2 | cut -d - -f 1)/*.zip cirrus:$(grep unch $CIRRUS_WORKING_DIR/build_rom.sh -m 1 | cut -d ' ' -f 2 | cut -d _ -f 2 | cut -d - -f 1) -P
