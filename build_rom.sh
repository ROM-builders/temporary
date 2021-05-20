# sync rom
repo init --depth=1 -u https://github.com/Wave-Project/manifest -b r
git clone https://github.com/yashlearnpython/android_device_xiaomi_mido -b wave-os device/xiaomi/mido && git clone https://github.com/yashlearnpython/proprietary_vendor_xiaomi -b lineage-18.1 vendor/xiaomi && git clone https://github.com/yashlearnpython/android_kernel_xiaomi_mido -b lineage-18.1 kernel/xiaomi/mido
repo sync -c --force-sync --optimized-fetch --no-tags --no-clone-bundle --prune -j$(nproc --all)

# build rom
source build/envsetup.sh
brunch mido

# upload rom
# If you need to upload json/multiple files too then put like this 'rclone copy out/target/product/mido/*.zip cirrus:mido -P && rclone copy out/target/product/mido/*.zip.json cirrus:mido -P'
rclone copy out/target/product/mido/*.zip cirrus:mido -P
