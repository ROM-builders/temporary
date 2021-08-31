# sync rom
repo init --depth=1 --no-repo-verify -u git://github.com/exthmui/android.git -b exthm-11 -g default,-device,-mips,-darwin,-notdefault
git clone https://github.com/Naveen-nk1/local-manifest.git --depth 1 -b exthmui .repo/local_manifest
repo sync -c --no-clone-bundle --no-tags --optimized-fetch --prune --force-sync -j8

# build rom
source build/envsetup.sh
lunch exthm_X00T-userdebug
export TZ=Asia/Kolkata #put before last build command
mka der

# upload rom (if you don't need to upload multiple files, then you don't need to edit next line)
rclone copy out/target/product/$(grep unch $CIRRUS_WORKING_DIR/build_rom.sh -m 1 | cut -d ' ' -f 2 | cut -d _ -f 2 | cut -d - -f 1)/*.zip cirrus:$(grep unch $CIRRUS_WORKING_DIR/build_rom.sh -m 1 | cut -d ' ' -f 2 | cut -d _ -f 2 | cut -d - -f 1) -P
