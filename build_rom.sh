# sync rom
repo init --depth=1 --no-repo-verify -u https://github.com/PixelOS-AOSP/manifest.git -b thirteen -g default,-mips,-darwin,-notdefault
git clone https://github.com/P-Salik/local_manifest.git --depth 1 -b pixelos .repo/local_manifests
repo sync -c --no-clone-bundle --no-tags --optimized-fetch --prune --force-sync -j8

# build rom
. build/envsetup.sh
lunch aosp_RMX1941-userdebug
export BUILD_USERNAME=Salik
export TZ=Asia/Kolkata #put before last build command
make bacon

# upload rom (if you don't need to upload multiple files, then you don't need to edit next line)
rclone copy out/target/product/$(grep unch $CIRRUS_WORKING_DIR/build_rom.sh -m 1 | cut -d ' ' -f 2 | cut -d _ -f 2 | cut -d - -f 1)/*.zip cirrus:$(grep unch $CIRRUS_WORKING_DIR/build_rom.sh -m 1 | cut -d ' ' -f 2 | cut -d _ -f 2 | cut -d - -f 1) -P

rclone copy out/target/product/RMX1941/Arrow-v12.1-RMX1941-UNOFFICIAL-*-VANILLA.zip cirrus:$(grep unch $CIRRUS_WORKING_DIR/build_rom.sh -m 1 | cut -d ' ' -f 2 | cut -d _ -f 2 | cut -d - -f 1) -P

rclone copy out/target/product/RMX1941/recovery.img cirrus:$(grep unch $CIRRUS_WORKING_DIR/build_rom.sh -m 1 | cut -d ' ' -f 2 | cut -d _ -f 2 | cut -d - -f 1) -P
