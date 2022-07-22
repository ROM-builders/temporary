# sync rom
repo init --depth=1 --no-repo-verify -u https://github.com/ForkLineageOS/android -b lineage-19.1 -g default,-mips,-darwin,-notdefault
git clone https://github.com/S8M1T/local_manifest.git --depth 1 -b main .repo/local_manifests
repo sync -c --no-clone-bundle --no-tags --optimized-fetch --prune --force-sync -j8
 
# build rom
. build/envsetup.sh
lunch lineage_RMX3360-userdebug
export TARGET_FLOS=true
export TZ=Asia/Kolkata #put before last build command
mka bacon

# upload rom (if you don't need to upload multiple files, then you don't need to edit next line)
rclone copy out/target/product/$(grep unch $CIRRUS_WORKING_DIR/build_rom.sh -m 1 | cut -d ' ' -f 2 | cut -d _ -f 2 | cut -d - -f 1)/*.zip cirrus:$(grep unch $CIRRUS_WORKING_DIR/build_rom.sh -m 1 | cut -d ' ' -f 2 | cut -d _ -f 2 | cut -d - -f 1) -P
