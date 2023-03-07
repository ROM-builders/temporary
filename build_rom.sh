# Sync
repo init -u https://github.com/ArrowOS/android_manifest.git -b arrow-11.0
git clone https://github.com/NikodGithub/local_manifest.git --depth 1 -b master .repo/local_manifests
repo sync -c --no-clone-bundle --no-tags --optimized-fetch --prune --force-sync -j8

# Build
source build/envsetup.sh
lunch arrow_lava-userdebug
export TZ=Asia/Dhaka
m otapackage
export BUILD_USERNAME=Nikod

# Upload
rclone copy out/target/product/$(grep unch $CIRRUS_WORKING_DIR/build_rom.sh -m 1 | cut -d ' ' -f 2 | cut -d _ -f 2 | cut -d - -f 1)/*.zip cirrus:$(grep unch $CIRRUS_WORKING_DIR/build_rom.sh -m 1 | cut -d ' ' -f 2 | cut -d _ -f 2 | cut -d - -f 1) -P
