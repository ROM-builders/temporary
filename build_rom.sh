repo init -u https://github.com/PixelOS-AOSP/manifest -b twelve -g default,-mips,-darwin,-notdefault
git clone git://github.com/mountain47/local_manifest.git --depth 1 -b main .repo/local_manifest
repo sync -c --force-sync --optimized-fetch --no-tags --no-clone-bundle --prune -j8
# build rom
# Set up environment
source build/envsetup.sh
# Choose a target
lunch aosp_moon-user
# Build the code
mka bacon -j8
export TZ=Asia/Dhaka #put before last build command

# upload rom (if you don't need to upload multiple files, then you don't need to edit next line)
rclone copy out/target/product/$(grep unch $CIRRUS_WORKING_DIR/build_rom.sh -m 1 | cut -d ' ' -f 2 | cut -d _ -f 2 | cut -d - -f 1)/*.zip cirrus:$(grep unch $CIRRUS_WORKING_DIR/build_rom.sh -m 1 | cut -d ' ' -f 2 | cut -d _ -f 2 | cut -d - -f 1) -P
