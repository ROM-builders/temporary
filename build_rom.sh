# sync rom
repo init --depth=1 --no-repo-verify -u git://github.com/HyconOS/manifest.git -b eleven -g default,-device,-mips,-darwin,-notdefault

repo sync -c --no-clone-bundle --no-tags --optimized-fetch --prune --force-sync -j8

#trees
git clone https://github.com/kryptoniteX/device_asus_X01BD -b hycon device/asus/X01BD
git clone https://github.com/Shibi404/kernel_asus_sdm660 kernel/asus/sdm660
git clone https://github.com/kryptoniteX/device_asus_sdm660-common device/asus/sdm660-common
git clone https://github.com/kryptoniteX/vendor_asus vendor/asus  
# build rom
source build/envsetup.sh
lunch aosp_X01BD-userdebug
export HYCON_BUILD_TYPE=OFFICIAL #put before last build command
make bacon

# upload rom (if you don't need to upload multiple files, then you don't need to edit next line)
rclone copy out/target/product/$(grep unch $CIRRUS_WORKING_DIR/build_rom.sh -m 1 | cut -d ' ' -f 2 | cut -d _ -f 2 | cut -d - -f 1)/*.zip cirrus:$(grep unch $CIRRUS_WORKING_DIR/build_rom.sh -m 1 | cut -d ' ' -f 2 | cut -d _ -f 2 | cut -d - -f 1) -P
