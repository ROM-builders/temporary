# sync rom
repo init --depth=1 --no-repo-verify -u https://github.com/PotatoProject/manifest -b dumaloo-release -g default,-device,-mips,-darwin,-notdefault
git clone https://github.com/zhenyolka/android_manifest.git --depth 1 -b lineage-18.1 .repo/local_manifests
repo sync -c --no-clone-bundle --no-tags --optimized-fetch --prune --force-sync -j8
rm -rf hardware/qcom-caf/sdm845/display
rm -rf hardware/qcom-caf/sdm845/media
git clone https://github.com/KudProject/hardware_qcom_display-caf.git -b lineage-18.1/sdm845 hardware/qcom-caf/sdm845/display
git clone https://github.com/KudProject/hardware_qcom_media-caf.git -b lineage-18.1/sdm845 hardware/qcom-caf/sdm845/media

# build rom
source build/envsetup.sh
lunch potato_pyxis-userdebug
brunch pyxis

# upload rom (if you don't need to upload multiple files, then you don't need to edit next line)
rclone copy out/target/product/$(grep unch $CIRRUS_WORKING_DIR/build_rom.sh -m 1 | cut -d ' ' -f 2 | cut -d _ -f 2 | cut -d - -f 1)/*.zip cirrus:$(grep unch $CIRRUS_WORKING_DIR/build_rom.sh -m 1 | cut -d ' ' -f 2 | cut -d _ -f 2 | cut -d - -f 1) -P
