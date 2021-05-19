# sync rom
repo init --depth=1 -u https://github.com/PotatoProject/manifest -b dumaloo-release; -g default,-device,-mips,-darwin,-notdefault
repo sync -c --no-clone-bundle --no-tags --optimized-fetch --prune --force-sync -j8 || repo sync -c --no-clone-bundle --no-tags --optimized-fetch --prune --force-sync -j8

git clone https://github.com/PotatoDevices/device_xiaomi_violet.git device/xiaomi/violet
git clone https://github.com/PotatoDevices/kernel_xiaomi_violet.git kernel/xiaomi/violet --depth 1
git clone https://github.com/PotatoDevices/vendor_xiaomi_violet.git vendor/xiaomi/violet --depth 1
git clone https://github.com/adi8900/vendor_xiaomi_dirac.git vendor/xiaomi/dirac --depth 1


# build rom
source build/envsetup.sh
lunch potato_violet-user
brunch violet

# upload rom
rclone copy out/target/product/violet/*.zip cirrus:mido -P
