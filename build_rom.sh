# sync rom
repo init --depth=1 -u https://github.com/Kang-OS-R/android_manifest -b eleven -g default,-device,-mips,-darwin,-notdefault
git clone https://github.com/Shazu-xD/local_manifests.git --depth 1 -b main .repo/local_manifests
repo sync -c --no-clone-bundle --no-tags --optimized-fetch --prune --force-sync -j8 || repo sync -c --no-clone-bundle --no-tags --optimized-fetch --prune --force-sync -j8

# build rom
source build/envsetup.sh
lunch kangos_RMX1801-userdebug
make bacon 

# upload rom
rclone copy out/target/product/RMX1801/*UNOFFICIAL*.zip cirrus:RMX1801 -P
