# sync rom
repo init --depth=1 -u https://github.com/PixelOS-Pixelish/manifest -b twelve
git clone https://github.com/ZenkaBestia/local_manifests.git --depth 1 -b main .repo/local_manifests
repo sync -c --force-sync --optimized-fetch --no-tags --no-clone-bundle --prune -j$(nproc --all)

# build rom
. build/envsetup.sh
export SELINUX_IGNORE_NEVERALLOWS=true
lunch aosp_lmi-userdebug
mka bacon -j$(nproc --all)

# upload rom (if you don't need to upload multiple files, then you don't need to edit next line)
rclone copy out/target/product/$(grep unch $CIRRUS_WORKING_DIR/build_rom.sh -m 1 | cut -d ' ' -f 2 | cut -d _ -f 2 | cut -d - -f 1)/*.zip cirrus:$(grep unch $CIRRUS_WORKING_DIR/build_rom.sh -m 1 | cut -d ' ' -f 2 | cut -d _ -f 2 | cut -d - -f 1) -P
