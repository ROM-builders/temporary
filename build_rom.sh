# sync rom
repo init -u https://github.com/DerpFest-AOSP/manifest.git -b 13 
git clone https://github.com/vignesvicky2/local_manifest.git --depth 1 -b main .repo/local_manifests --depth 1 -b master .repo/local_manifests
repo sync -c --no-clone-bundle --no-tags --optimized-fetch --prune --force-sync -j8
# build rom1
source build/envsetup.sh
lunch drep_yogurt-user
export BUILD_BROKEN_MISSING_REQUIRED_MODULES=true
export TZ=Asia/Dhaka
mka drep

# upload rom (if you don't need to upload multiple files, then you don't need to edit next line)
rclone copy out/target/product/$(grep unch $CIRRUS_WORKING_DIR/build_rom.sh -m 1 | cut -d ' ' -f 2 | cut -d _ -f 2 | cut -d - -f 1)/*.zip cirrus:$(grep unch $CIRRUS_WORKING_DIR/build_rom.sh -m 1 | cut -d ' ' -f 2 | cut -d _ -f 2 | cut -d - -f 1) -P
