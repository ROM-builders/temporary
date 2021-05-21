# sync rom
repo init --depth=1 -u git://github.com/lighthouse-os/manifest.git -b raft -g default,-device,-mips,-darwin,-notdefault
repo sync -c --no-clone-bundle --no-tags --optimized-fetch --prune --force-sync -j8 || repo sync -c --no-clone-bundle --no-tags --optimized-fetch --prune --force-sync -j8

git clone https://github.com/lighthouse-os-devices/device_xiaomi_violet.git device/xiaomi/violet
git clone https://github.com/lighthouse-os-devices/kernel_xiaomi_violet.git kernel/xiaomi/violet --depth 1
git clone https://github.com/lighthouse-os-devices/vendor_xiaomi_violet.git vendor/xiaomi/violet --depth 1


# build rom
sudo apt update && sudo apt -y install cpio
source build/envsetup.sh
lunch lighthouse_violet-userdebug
mka lighthouse

# upload rom
# If you need to upload json/multiple files too then put like this 'rclone copy out/target/product/mido/*.zip cirrus:mido -P && rclone copy out/target/product/mido/*.zip.json cirrus:mido -P'
rclone copy out/target/product/violet/*.zip cirrus:mido -P
