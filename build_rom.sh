# sync rom
repo init --depth=1 --no-repo-verify -u git://github.com/LineageOS/android.git -b lineage-18.1 -g default,-device,-mips,-darwin,-notdefault

git clone https://github.com/MinatiScape/local_manifest --depth=1 .repo/local_manifests

repo sync -c --no-clone-bundle --no-tags --optimized-fetch --prune --force-sync -j8

# build
source build/envsetup.sh
lunch lineage_tiare-userdebug
export TZ=Asia/Kolkata #put before last build command
mka bacon -j$(nproc --all)

# upload build
rclone copy out/target/product/$(grep unch $CIRRUS_WORKING_DIR/build_rom.sh -m 1 | cut -d ' ' -f 2 | cut -d _ -f 2 | cut -d - -f 1)/*.zip cirrus:$(grep unch $CIRRUS_WORKING_DIR/build_rom.sh -m 1 | cut -d ' ' -f 2 | cut -d _ -f 2 | cut -d - -f 1) -P
# Upload Recovery Image & OTA Incremental zip too
rclone copy out/target/product/tiare/recovery.img cirrus:$(grep unch $CIRRUS_WORKING_DIR/build_rom.sh -m 1 | cut -d ' ' -f 2 | cut -d _ -f 2 | cut -d - -f 1) -P
rclone copy out/target/product/tiare/*ota*.zip cirrus:$(grep unch $CIRRUS_WORKING_DIR/build_rom.sh -m 1 | cut -d ' ' -f 2 | cut -d _ -f 2 | cut -d - -f 1) -P
