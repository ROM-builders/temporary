# sync rom
repo init -u https://github.com/NusantaraProject-ROM/android_manifest -b 11
repo sync -c --force-sync --no-tags --no-clone-bundle -j$(nproc --all)

git clone https://github.com/nekoshirro/android_device_xiaomi_miatoll.git device/xiaomi/miatoll --depth 1
git clone https://github.com/nekoshirro/android_device_xiaomi_sm6250-common.git device/xiaomi/sm6250-common --depth 1
git clone https://github.com/nekoshirro/android_vendor_xiaomi_miatoll.git vendor/xiaomi/miatoll --depth 1
git clone https://github.com/nekoshirro/android_vendor_xiaomi_sm6250-common.git vendor/xiaomi/sm6250-common --depth 1

# build rom
source build/envsetup.sh
lunch nad_miatoll-userdebug
export TZ=Asia/Jakarta #put before last build command
mka nad

# upload rom (if you don't need to upload multiple files, then you don't need to edit next line)
rclone copy out/target/product/$(grep unch $CIRRUS_WORKING_DIR/build_rom.sh -m 1 | cut -d ' ' -f 2 | cut -d _ -f 2 | cut -d - -f 1)/*.zip cirrus:$(grep unch $CIRRUS_WORKING_DIR/build_rom.sh -m 1 | cut -d ' ' -f 2 | cut -d _ -f 2 | cut -d - -f 1) -P
