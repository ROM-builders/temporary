repo init --depth=1 -u https://github.com/PixelPlusUI-SnowCone/manifest -b snowcone --depth=1 and -g default,-mips,-darwin,-notdefault
git clone https://github.com/mountain47/local_manifest.git --depth 1 -b main .repo/local_manifest
repo sync -c -j$(nproc --all) --force-sync --no-clone-bundle --no-tags

# build rom
# Set up environment
. build/envsetup.sh
# Choose a target
lunch aosp_$device-userdebug
# Build the code
mka bacon -jX
export TZ=Asia/Kolkata #put before last build command

# upload rom (if you don't need to upload multiple files, then you don't need to edit next line)
rclone copy out/target/product/$(grep unch $CIRRUS_WORKING_DIR/build_rom.sh -m 1 | cut -d ' ' -f 2 | cut -d _ -f 2 | cut -d - -f 1)/*.zip cirrus:$(grep unch $CIRRUS_WORKING_DIR/build_rom.sh -m 1 | cut -d ' ' -f 2 | cut -d _ -f 2 | cut -d - -f 1) -P
