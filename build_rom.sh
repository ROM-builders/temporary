# sync rom
repo init --depth=1 --no-repo-verify -u https://github.com/P-404/platform_manifest -b 11 -g default,-device,-mips,-darwin,-notdefault
git clone https://github.com/yograjsingh-cmd/local_manifest.git --depth=1 -b 404  .repo/local_manifests
repo sync -c --no-clone-bundle --no-tags --optimized-fetch --prune --force-sync -j8

# build rom
source build/envsetup.sh
lunch p404_Z01R-userdebug
export ALLOW_MISSING_DEPENDENCIES=true
export TZ=Asia/Kolkata 
make bacon

# upload rom (if you don't need to upload multiple files, then you don't need to edit next line)
rclone copy out/target/product/$(grep unch $CIRRUS_WORKING_DIR/build_rom.sh -m 1 | cut -d ' ' -f 2 | cut -d _ -f 2 | cut -d - -f 1)/*.zip cirrus:$(grep unch $CIRRUS_WORKING_DIR/build_rom.sh -m 1 | cut -d ' ' -f 2 | cut -d _ -f 2 | cut -d - -f 1) -P
