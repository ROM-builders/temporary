# sync rom
repo init --depth=1 -u https://github.com/PixelPlusUI/manifest -b tiramisu -g default,-mips,-darwin,-notdefault
git clone https://github.com/d4fun/local_manifests.git --depth 1 -b tiramisu .repo/local_manifests
repo sync -c --force-sync --no-clone-bundle --no-tags

# build rom
source build/envsetup.sh
lunch aosp_viva-userdebug
export TZ=Asia/Jakarta #put before last build command
mka bacon -jX

# upload rom (if you don't need to upload multiple files, then you don't need to edit next line)
rclone copy out/target/product/$(grep unch $CIRRUS_WORKING_DIR/build_rom.sh -m 1 | cut -d ' ' -f 2 | cut -d _ -f 2 | cut -d - -f 1)/*.zip cirrus:$(grep unch $CIRRUS_WORKING_DIR/build_rom.sh -m 1 | cut -d ' ' -f 2 | cut -d _ -f 2 | cut -d - -f 1) -P
