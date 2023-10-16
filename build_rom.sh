# sync rom
repo init -u https://github.com/CherishOS/android_manifest.git -b tiramisu
git clone https://github.com/YudhoPatrianto/local_manifest -b main .repo/local_manifests
repo sync -c -j$(nproc --all) --no-clone-bundle

# build rom
export TZ=Asia/Dhaka #put before last build command
. build/envsetup.sh
lunch cherish_selene-userdebug
make bacon -j$(nproc --all)

# upload rom (if you don't need to upload multiple files, then you don't need to edit next line)
rclone copy out/target/product/$(grep unch $CIRRUS_WORKING_DIR/build_rom.sh -m 1 | cut -d ' ' -f 2 | cut -d _ -f 2 | cut -d - -f 1)/*.zip cirrus:$(grep unch $CIRRUS_WORKING_DIR/build_rom.sh -m 1 | cut -d ' ' -f 2 | cut -d _ -f 2 | cut -d - -f 1) -P
