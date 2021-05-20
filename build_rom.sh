# sync rom
repo init --depth=1 -u https://github.com/PixelPlusUI/manifest.git -b eleven.x -g default,-device,-mips,-darwin,-notdefault
git clone https://github.com/Frachze97/local_manifests.git --depth 1 -b main .repo/local_manifests
repo sync -c --no-clone-bundle --no-tags --optimized-fetch --prune --force-sync -j8 || repo sync -c --no-clone-bundle --no-tags --optimized-fetch --prune --force-sync -j8

# build rom
source build/envsetup.sh
export USE_GAPPS = true
lunch aosp_RMX1941-userdebug
mka bacon -jX

# upload rom
rclone copy out/target/product/RMX1941/*UNOFFICIAL*.zip cirrus:RMX1941 -P  
