# sync rom
repo init -u https://github.com/omnirom/android.git -b android-13.0 -b 11 -g default,-mips,-darwin,-notdefault
git clone https://github.com/dudu2504/Vayu/blob/d2265ae6a9cd01210a9d94f967506d00eaaafe4b/local_manifest.xml --depth 1 -b principal .repo/local_manifests
repo sync -c --no-clone-bundle --no-tags --optimized-fetch --prune --force-sync -j8

# build rom
source build/envsetup.sh
lunch derp_vayu-user
export TZ=Asia/Dhaka #put before last build command
mka derp

# upload rom (if you don't need to upload multiple files, then you don't need to edit next line)
rclone copy out/target/product/$(grep unch $CIRRUS_WORKING_DIR/build_rom.sh -m 1 | cut -d ' ' -f 2 | cut -d _ -f 2 | cut -d - -f 1)/*.zip cirrus:$(grep unch $CIRRUS_WORKING_DIR/build_rom.sh -m 1 | cut -d ' ' -f 2 | cut -d _ -f 2 | cut -d - -f 1) -P
