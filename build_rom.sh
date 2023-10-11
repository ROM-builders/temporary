# sync rom
repo init --depth=1 --no-repo-verify -u https://github.com/alphadroid-project/manifest.git -b alpha-13 -g default,-mips,-darwin,-notdefault
git clone https://github.com/maxx459/local_manifest.git -b alpha .repo/local_manifests
repo sync -c --no-clone-bundle --no-tags --optimized-fetch --prune --force-sync -j8

# build rom
source build/envsetup.sh
lunch lineage_rova-userdebug
export ALLOW_MISSING_DEPENDENCIES=true
export BUILD_USERNAME=maxx
export BUILD_HOSTNAME=maxx459
export TZ=Asia/Kolkata #put before last build command
mka bacon

# upload rom (if you don't need to upload multiple files, then you don't need to edit next line)
rclone copy out/target/product/$(grep unch $CIRRUS_WORKING_DIR/build_rom.sh -m 1 | cut -d ' ' -f 2 | cut -d _ -f 2 | cut -d - -f 1)/*.zip cirrus:$(grep unch $CIRRUS_WORKING_DIR/build_rom.sh -m 1 | cut -d ' ' -f 2 | cut -d _ -f 2 | cut -d - -f 1) -P
