# sync rom
repo init -u https://github.com/bananadroid/android_manifest.git -b 13 --git-lfs
git clone https://github.com/belugaA330/local_manifests.git --depth 1 -b ysl .repo/local_manifests
repo sync -c -j$(nproc --all) --force-sync --no-clone-bundle --no-tags --optimized-fetch --prune
# build rom
. build/envsetup.sh
lunch banana_ysl-userdebug
export KBUILD_BUILD_USER=beluga 
export KBUILD_BUILD_HOST=flybeluga 
export BUILD_USERNAME=beluga
export BUILD_HOSTNAME=flybeluga
export BUILD_BROKEN_MISSING_REQUIRED_MODULES=true
export TZ=Asia/Jakarta #put before last build command
m banana

# upload rom (if you don't need to upload multiple files, then you don't need to edit next line)
rclone copy out/target/product/$(grep unch $CIRRUS_WORKING_DIR/build_rom.sh -m 1 | cut -d ' ' -f 2 | cut -d _ -f 2 | cut -d - -f 1)/*.zip cirrus:$(grep unch $CIRRUS_WORKING_DIR/build_rom.sh -m 1 | cut -d ' ' -f 2 | cut -d _ -f 2 | cut -d - -f 1) -P
