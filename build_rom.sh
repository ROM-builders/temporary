# sync rom
repo init --depth=1 --no-repo-verify -u git://github.com/LineageOS/android.git -b lineage-17.1 -g default,-device,-mips,-darwin,-notdefault
git clone https://github.com/Kakplis/local_manifest.git --depth 1 -b main .repo/local_manifests
repo sync -c --no-clone-bundle --no-tags --optimized-fetch --prune --force-sync -j8

# build rom
source build/envsetup.sh
lunch lineage_X00TD-userdebug
export LINEAGE_VERSION_APPEND_TIME_OF_DAY=true
export SKIP_ABI_CHECKS=true
export SKIP_API_CHECKS=true
make bacon -j$(nproc --all)

# upload rom (if you don't need to upload multiple files, then you don't need to edit next line)
rclone copy out/target/product/$(grep unch $CIRRUS_WORKING_DIR/build_rom.sh -m 1 | cut -d ' ' -f 2 | cut -d _ -f 2 | cut -d - -f 1)/*.zip cirrus:$(grep unch $CIRRUS_WORKING_DIR/build_rom.sh -m 1 | cut -d ' ' -f 2 | cut -d _ -f 2 | cut -d - -f 1) -P
