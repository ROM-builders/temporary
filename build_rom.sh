# sync rom
repo init --depth=1 --no-repo-verify -u git://github.com/LineageOS/android.git -b lineage-17.1 -g default,-device,-mips,-darwin,-notdefault
git clone https://github.com/Micromax-E6746/local_manifests.git --depth 1 -b test3 .repo/local_manifests
repo sync -c --no-clone-bundle --no-tags --optimized-fetch --prune --force-sync -j8

# build rom run
#finalize-fix
source build/envsetup.sh
lunch lineage_e6746-userdebug
echo $(get_build_var TARGET_PRODUCT)
echo $(get_build_var TARGET_BUILD_VARIANT)
export TZ=Asia/Kolkata
mka bacon

# upload rom (if you don't need to upload multiple files, then you don't need to edit next line)
rclone copy out/target/product/$(grep unch $CIRRUS_WORKING_DIR/build_rom.sh -m 1 | cut -d ' ' -f 2 | cut -d _ -f 2 | cut -d - -f 1)/*.zip cirrus:$(grep unch $CIRRUS_WORKING_DIR/build_rom.sh -m 1 | cut -d ' ' -f 2 | cut -d _ -f 2 | cut -d - -f 1) -P
