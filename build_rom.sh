# sync rom
repo init -u https://github.com/CherishOS/android_manifest.git -b tiramisu
git clone https://github.com/Assunzain/local_manifest -b cherish .repo/local_manifests
repo sync -c -j$(nproc --all) --no-clone-bundle

# build rom
export TZ=Asia/Jakarta #put before last build command
. build/envsetup.sh
lunch cherish_X01AD-userdebug
export ALLOW_MISSING_DEPENDENCIES=true
make bacon -j$(nproc --all)

# upload rom (if you don't need to upload multiple files, then you don't need to edit next line)
rclone copy out/target/product/$(grep unch $CIRRUS_WORKING_DIR/build_rom.sh -m 1 | cut -d ' ' -f 2 | cut -d _ -f 2 | cut -d - -f 1)/*.zip cirrus:$(grep unch $CIRRUS_WORKING_DIR/build_rom.sh -m 1 | cut -d ' ' -f 2 | cut -d _ -f 2 | cut -d - -f 1) -P
