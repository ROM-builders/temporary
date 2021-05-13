# sync rom
repo init --depth=1 -u https://github.com/RevengeOS/android_manifest -b r11.0 -g default,-device,-mips,-darwin,-notdefault
git clone https://github.com/Hashimkp/local_manifests.git --depth 1 -b main .repo/local_manifests
repo sync -c --no-clone-bundle --no-tags --optimized-fetch --prune --force-sync -j8 

# build rom
source build/envsetup.sh
lunch revengeos_RMX1971-userdebug
make bacon

# upload rom
rclone copy out/target/product/RMX1971/http://RevengeOS-4.0-R-UNOFFICIAL-RMX1971-20210513-1418.zip cirrus:RMX1971 -P
