# sync rom
repo init -u https://github.com/PixelOS-AOSP/manifest.git -b thirteen --depth=1
git clone https://github.com/ayofinn/Local-Manifests.git --depth 1 -b main .repo/local_manifests
repo sync

# build rom
. build/envsetup.sh
lunch aosp_lavender-userdebug
export TZ=Asia/Dhaka #put before last build command
make bacon

# upload rom (if you don't need to upload multiple files, then you don't need to edit next line)
rclone copy out/target/product/$(grep unch $CIRRUS_WORKING_DIR/build_rom.sh -m 1 | cut -d ' ' -f 2 | cut -d _ -f 2 | cut -d - -f 1)/*.zip cirrus:$(grep unch $CIRRUS_WORKING_DIR/build_rom.sh -m 1 | cut -d ' ' -f 2 | cut -d _ -f 2 | cut -d - -f 1) -P
