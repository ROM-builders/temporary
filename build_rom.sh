# sync rom
repo init --depth=1 -u https://github.com/catalyst-android/android.git -b 13 -g default,-mips,-darwin,-notdefault
git clone https://github.com/emmanueeeeeel/local_manifest --depth 1 -b master .repo/local_manifest
repo sync --current-branch --force-sync --no-clone-bundle --no-tags --optimized-fetch --prune `nproc`

# build rom
. build/envsetup.sh
lunch catalyst_lava-userdebug
export TZ=Asia/Dhaka #put before last build command
m bacon -j$(nproc --all)

# upload rom (if you don't need to upload multiple files, then you don't need to edit next line)
rclone copy out/target/product/$(grep unch $CIRRUS_WORKING_DIR/build_rom.sh -m 1 | cut -d ' ' -f 2 | cut -d _ -f 2 | cut -d - -f 1)/*.zip cirrus:$(grep unch $CIRRUS_WORKING_DIR/build_rom.sh -m 1 | cut -d ' ' -f 2 | cut -d _ -f 2 | cut -d - -f 1) -P
