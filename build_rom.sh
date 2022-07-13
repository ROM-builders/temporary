# sync rom
repo init --depth=1 -u https://github.com/Corvus-R/android_manifest.git -b 12-test
git clone https://github.com/Mr-Prince0/corvus-manifest-.git --depth 1 -b main .repo/corvus_manifests
repo sync -j$(nproc --all) --force-sync --no-tags --no-clone-bundle

# build rom
build/envsetup.sh
lunch corvus_device-userdebug
export TZ=Asia/Dhaka #put before last build command
make corvus

# upload rom (if you don't need to upload multiple files, then you don't need to edit next line)
rclone copy out/target/product/$(grep unch $CIRRUS_WORKING_DIR/build_rom.sh -m 1 | cut -d ' ' -f 2 | cut -d _ -f 2 | cut -d - -f 1)/*.zip cirrus:$(grep unch $CIRRUS_WORKING_DIR/build_rom.sh -m 1 | cut -d ' ' -f 2 | cut -d _ -f 2 | cut -d - -f 1) -P
