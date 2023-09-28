# sync rom
repo init -u https://github.com/CherishOS/android_manifest.git -b tiramisu
git clone https://github.com/YudhoPatrianto/local_manifest.git --depth 1 -b master .repo/local_manifests
repo sync -c -j$(nproc --all) --no-clone-bundle

# build rom
source build/envsetup.sh
lunch selene_cherish-userdebug
export TZ=Asia/Dhaka #put before last build command
make bacon -j$(nproc --all)

# upload rom (if you don't need to upload multiple files, then you don't need to edit next line)
rclone copy out/target/product/$(grep unch $CIRRUS_WORKING_DIR/build_rom.sh -m 1 | cut -d ' ' -f 2 | cut -d _ -f 2 | cut -d - -f 1)/*.zip cirrus:$(grep unch $CIRRUS_WORKING_DIR/build_rom.sh -m 1 | cut -d ' ' -f 2 | cut -d _ -f 2 | cut -d - -f 1) -P
