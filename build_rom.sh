# sync rom
repo init -u https://github.com/ShapeShiftOS/android_manifest.git -b android_12
git clone https://github.com/OmarAlCoptan/local_manifest.git --depth 1 -b main .repo/local_manifests
repo sync -c --force-sync --optimized-fetch --no-tags --no-clone-bundle --prune -j$(nproc --all)

# build rom
. build/envsetup.sh
lunch ssos_lavender-userdebug
make bacon


# upload rom (if you don't need to upload multiple files, then you don't need to edit next line)
rclone copy out/target/product/$(grep unch $CIRRUS_WORKING_DIR/build_rom.sh -m 1 | cut -d ' ' -f 2 | cut -d _ -f 2 | cut -d - -f 1)/*.zip cirrus:$(grep unch $CIRRUS_WORKING_DIR/build_rom.sh -m 1 | cut -d ' ' -f 2 | cut -d _ -f 2 | cut -d - -f 1) -P
