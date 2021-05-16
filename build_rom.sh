# sync rom
repo init -u https://github.com/Kang-OS-R/android_manifest -b eleven -g default,-device,-mips,-darwin,-notdefault
git clone https://github.com/thebuildbomt/local_manifests.git --depth 1 -b los .repo/local_manifests
repo sync -c --no-clone-bundle --no-tags --optimized-fetch --prune --force-sync -j8 || repo sync -c --no-clone-bundle --no-tags --optimized-fetch --prune --force-sync -j8

# build rom
source build/envsetup.sh
lunch kangos_RMX1801-userdebug
make bacon 

# upload rom
rclone copy out/target/product/RMX1801/kangos*.zip cirrus:RMX1801 -P
