# sync rom
repo init --depth=1 --no-repo-verify -u git://github.com/PixelExperience-Staging/gerrit_manifest.git -b main -g default,-mips,-darwin,-notdefault
git clone https://github.com/inferno964/local_manifest.git --depth 1 -b master .repo/local_manifests
repo sync -c --no-clone-bundle --no-tags --optimized-fetch --prune --force-sync -j8

# build rom
cd system 
rm -rf sepolicy
git clone https://github.com/sohamxda7/platform_system_sepolicy sepolicy
cd
rm -rf device/qcom/sepolicy-legacy-um
git clone https://github.com/sohamxda7/device_qcom_sepolicy-legacy-um device/qcom/sepolicy-legacy-um
. build/envsetup.sh
lunch aosp_lavender-userdebug
mka bacon

# upload rom (if you don't need to upload multiple files, then you don't need to edit next line)
rclone copy out/target/product/$(grep unch $CIRRUS_WORKING_DIR/build_rom.sh -m 1 | cut -d ' ' -f 2 | cut -d _ -f 2 | cut -d - -f 1)/*.zip cirrus:$(grep unch $CIRRUS_WORKING_DIR/build_rom.sh -m 1 | cut -d ' ' -f 2 | cut -d _ -f 2 | cut -d - -f 1) -P
