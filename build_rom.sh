# sync rom
repo init -u https://github.com/PixelExperience/manifest -b eleven -g default,-device,-mips,-darwin,-notdefault
git clone https://github.com/Shazu_xD/local_manifests.git --depth 1 -b aex .repo/local_manifests
repo sync -c --no-clone-bundle --no-tags --optimized-fetch --prune --force-sync -j8 || repo sync -c --no-clone-bundle --no-tags --optimized-fetch --prune --force-sync -j8

# build rom
source build/envsetup.sh
lunch aosp_RMX1801-userdebug
mka bacon -jx

# upload rom
rclone copy out/target/product/RMX1801/aosp*.zip cirrus:RMX1801 -P
