# sync rom
repo init --depth=1 -u git://github.com/LineageOS/android.git -b refs/changes/23/317623/7 -g default,-mips,-darwin,-notdefault
git clone https://github.com/ibraaltabian17/local_manifest.git --depth 1 -b main .repo/local_manifests
repo sync -c --no-clone-bundle --no-tags --optimized-fetch --prune --force-sync -j8

# build rom
source build/envsetup.sh
lunch lineage_A6020-userdebug
export LINEAGE_VERSION_APPEND_TIME_OF_DAY=true
export ALLOW_MISSING_DEPENDENCIES=true
export SKIP_ABI_CHECKS=true
export SKIP_API_CHECKS=true
export TZ=Asia/Jakarta #put before last build command
mka bacon -j$(nproc --all)

# upload rom (if you don't need to upload multiple files, then you don't need to edit next line)
rclone copy out/target/product/$(grep unch $CIRRUS_WORKING_DIR/build_rom.sh -m 1 | cut -d ' ' -f 2 | cut -d _ -f 2 | cut -d - -f 1)/*.zip cirrus:$(grep unch $CIRRUS_WORKING_DIR/build_rom.sh -m 1 | cut -d ' ' -f 2 | cut -d _ -f 2 | cut -d - -f 1) -P
