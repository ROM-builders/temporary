# sync rom
repo init -u https://github.com/Corvus-R/android_manifest.git -b 11
git clone https://github.com/Corvus-R/android_manifest.git --depth 1 -b 11
repo sync -j$(nproc --all) --force-sync --no-tags --no-clone-bundle

# build rom
source build/envsetup.sh
lunch corvus_device-userdebug
export TZ=Asia/Dhaka 
make corvus

# upload rom (if you don't need to upload multiple files, then you don't need to edit next line)
rclone copy out/target/product/$(grep unch $CIRRUS_WORKING_DIR/build_rom.sh -m 1 | cut -d ' ' -f 2 | cut -d _ -f 2 | cut -d - -f 1)/*.zip cirrus:$(grep unch $CIRRUS_WORKING_DIR/build_rom.sh -m 1 | cut -d ' ' -f 2 | cut -d _ -f 2 | cut -d - -f 1) -P
