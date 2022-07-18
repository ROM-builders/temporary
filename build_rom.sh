# sync rom
repo init --depth=1 --no-repo-verify -u https://github.com/PixelExperience/manifest -b twelve-plus -g default,-mips,-darwin,-notdefault
repo sync -c -j$(nproc --all) --force-sync --no-clone-bundle --no-tags

# build rom
source build/envsetup.sh
lunch aosp_vangogh-userdebug
export TZ=Asia/Shanghai #put before last build command
croot
mka bacon

# upload rom (if you don't need to upload multiple files, then you don't need to edit next line)
rclone copy out/target/product/$(grep unch $CIRRUS_WORKING_DIR/build_rom.sh -m 1 | cut -d ' ' -f 2 | cut -d _ -f 2 | cut -d - -f 1)/*.zip cirrus:$(grep unch $CIRRUS_WORKING_DIR/build_rom.sh -m 1 | cut -d ' ' -f 2 | cut -d _ -f 2 | cut -d - -f 1) -P
rclone copy out/target/product/vangogh/*.zip.json cirrus:vangogh -P
