# sync rom
repo init --depth=1 --no-repo-verify -u https://github.com/Octavi-Staging/manifest.git -b thirteen-g default,-mips,-darwin,-notdefault
git clone https://github.com/Shravan55555/local_manifest.git .repo/local_manifests
repo sync -c --no-clone-bundle --no-tags --optimized-fetch --prune --force-sync -j8

# build rom
source build/envsetup.sh
lunch octavi_RMX1901-userdebug
export TZ=Asia/Kolkata #put before last build command
brunch RMX1901

# upload rom (if you don't need to upload multiple files, then you don't need to edit next line)
rclone copy out/target/product/$(grep unch $CIRRUS_WORKING_DIR/build_rom.sh -m 1 | cut -d ' ' -f 2 | cut -d _ -f 2 | cut -d - -f 1)/*.zip cirrus:$(grep unch $CIRRUS_WORKING_DIR/build_rom.sh -m 1 | cut -d ' ' -f 2 | cut -d _ -f 2 | cut -d - -f 1) -P
