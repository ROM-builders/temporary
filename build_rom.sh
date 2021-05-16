# sync rom
repo init -u https://github.com/Corvus-ROM/android_manifest.git -b 11 -g default,-device,-mips,-darwin,-notdefault
git clone https://github.com/GangsterPlayz1/local_manifests.git --depth 1 -b aex .repo/local_manifests
repo sync -c --no-clone-bundle --no-tags --optimized-fetch --prune --force-sync -j8 || repo sync -c --no-clone-bundle --no-tags --optimized-fetch --prune --force-sync -j8

# build rom
source build/envsetup.sh
lunch corvus_RMX1801-userdebug
make corvus

# upload rom
rclone copy out/target/product/RMX1801/corvus*.zip cirrus:RMX1801 -P
