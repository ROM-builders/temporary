# sync rom
repo init --depth=1 --no-repo-verify -u git://github.com/SuperiorOS/manifest.git -b eleven -g default,-device,-mips,-darwin,-notdefault
git clone https://github.com/indraadp/local_manifest --depth 1 -b superior .repo/local_manifests
repo sync -c --no-clone-bundle --no-tags --optimized-fetch --prune --force-sync -j8

# build rom (build 2nd)
source build/envsetup.sh
lunch superior_juice-userdebug
export TZ=Asia/Jakarta #put before last build command
mka bacon

# upload rom (if you don't need to upload multiple files, then you don't need to edit next line)
rclone copy out/target/product/$(grep unch $CIRRUS_WORKING_DIR/build_rom.sh -m 1 | cut -d ' ' -f 2 | cut -d _ -f 2 | cut -d - -f 1)/*.zip cirrus:$(grep unch $CIRRUS_WORKING_DIR/build_rom.sh -m 1 | cut -d ' ' -f 2 | cut -d _ -f 2 | cut -d - -f 1) -P
