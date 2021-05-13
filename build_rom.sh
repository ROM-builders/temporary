# sync rom
repo init --depth=1 -u git://github.com/Havoc-OS/android_manifest.git -b eleven -g default,-device,-mips,-darwin,-notdefault
git clone https://github.com/Hashimkp/local_manifests.git --depth=1 -b main .repo/local_manifests
repo sync -c --no-clone-bundle --no-tags --optimized-fetch --prune --force-sync -j$(nproc --all)

# build rom
source build/envsetup.sh
lunch havoc_RMX1971-userdebug
brunch RMX1971

# upload rom
rclone copy out/target/product/RMX1971/*.zip cirrus:RMX1971 -P
