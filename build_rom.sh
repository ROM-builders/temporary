# sync rom
repo init --depth=1 --no-repo-verify -u git://github.com/CherishOS/android_manifest.git -b eleven -g default,-device,-mips,-darwin,-notdefault
git clone https://github.com/RishikRastogi/local_manifest.git --depth 1 -b cherish .repo/local_manifests
repo sync -c -j$(nproc --all) --force-sync --no-clone-bundle --no-tags || repo sync -c --no-clone-bundle --no-tags --optimized-fetch --prune --force-sync -j8

# build rom
source build/envsetup.sh
lunch cherish_Z01R-userdebug
export SKIP_ABI_CHECKS=true
export TZ=Asia/Kolkata #put before last build command
mka bacon

# upload rom (if you don't need to upload multiple files, then you don't need to edit next line)
rclone copy out/target/product/$(grep unch $CIRRUS_WORKING_DIR/build_rom.sh -m 1 | cut -d ' ' -f 2 | cut -d _ -f 2 | cut -d - -f 1)/*.zip cirrus:$(grep unch $CIRRUS_WORKING_DIR/build_rom.sh -m 1 | cut -d ' ' -f 2 | cut -d _ -f 2 | cut -d - -f 1) -P
