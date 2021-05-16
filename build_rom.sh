# sync rom
repo init --depth=1 -u https://github.com/PixelExperience/manifest -b eleven -g default,-device,-mips,-darwin,-notdefault

git clone https://github.com/SparXFusion/local_manifests.git --depth=1 -b main .repo/local_manifests

repo sync -c --no-clone-bundle --no-tags --optimized-fetch --prune --force-sync -j$(nproc --all) || repo sync -c --no-clone-bundle --no-tags --optimized-fetch --prune --force-sync -j8

# build
. build/envsetup.sh
lunch aosp_RMX1941-userdebug
mka bacon -j$(nproc --all)

# upload build
rclone copy out/target/product/RMX1941/*UNOFFICIAL*.zip cirrus:RMX1941 -P
