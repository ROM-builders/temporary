repo init --depth=1 --no-repo-verify -u https://github.com/PixysOS/manifest -b eleven -g default,-mips,-darwin,-notdefault
git clone https://github.com/mountain47/local_manifest.git --depth 1 -b 11 .repo/local_manifests
repo sync -c --no-clone-bundle --no-tags --optimized-fetch --prune --force-sync -j8

# build rom
source build/envsetup.sh
lunch pixys_RMX2193-userdebug
make pixys
export TZ=Asia/Dhaka #put before last build command

# upload rom (if you don't need to upload multiple files, then you don't need to edit next line)
rclone copy out/target/product/$(grep unch $CIRRUS_WORKING_DIR/build_rom.sh -m 1 | cut -d ' ' -f 2 | cut -d _ -f 2 | cut -d - -f 1)/*.zip cirrus:$(grep unch $CIRRUS_WORKING_DIR/build_rom.sh -m 1 | cut -d ' ' -f 2 | cut -d _ -f 2 | cut -d - -f 1) -P
