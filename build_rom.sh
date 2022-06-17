# sync rom
repo init -u https://github.com/VoidUI/manifest -b aosp-12.1
git clone https://github.com/Pranav-Talmale/local_manifest_raphael_voidui.git -b main .repo/local_manifests
repo sync -c --no-clone-bundle --force-sync --no-clone-bundle --no-tags -j8

# build rom
. build/envsetup.sh
lunch aosp_raphael-userdebug
export TZ=Asia/Dhaka #put before last build command
mka bacon

# upload rom (if you don't need to upload multiple files, then you don't need to edit next line)
rclone copy out/target/product/$(grep unch $CIRRUS_WORKING_DIR/build_rom.sh -m 1 | cut -d ' ' -f 2 | cut -d _ -f 2 | cut -d - -f 1)/*.zip cirrus:$(grep unch $CIRRUS_WORKING_DIR/build_rom.sh -m 1 | cut -d ' ' -f 2 | cut -d _ -f 2 | cut -d - -f 1) -P
