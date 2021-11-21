# sync rom
repo init --depth=1 --no-repo-verify -u https://android.googlesource.com/platform/manifest -b android-12.0.0_r8 
git clone https://github.com/alin919/local_manifest-.git=repositories-depth 1 -b aosp_bonito-userdebug .repo/local_manifests
repo sync -c --no-clone-bundle --no-tags --optimized-fetch --prune --force-sync -j8

# build rom
source build/envsetup.sh
lunch aosp_bonito-userdebug

mka derp

# upload rom (if you don't need to upload multiple files, then you don't need to edit next line)
rclone copy out/target/product/$(grep unch $CIRRUS_WORKING_DIR/build_rom.sh -m 1 | cut -d ' ' -f 2 | cut -d _ -f 2 | cut -d - -f 1)/*.zip cirrus:$(grep unch $CIRRUS_WORKING_DIR/build_rom.sh -m 1 | cut -d ' ' -f 2 | cut -d _ -f 2 | cut -d - -f 1) -P
