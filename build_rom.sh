# sync rom
repo init --depth=1 -u https://github.com/PixelPlusUI/manifest -b eleven -g default,-device,-mips,-darwin,-notdefault

git clone https://github.com/Fraschze97/local_manifest.git --depth 1 -b main .repo/local_manifests

repo sync -c -j$(nproc --all) --force-sync --no-clone-bundle --no-tags

# build rom
source build/envsetup.sh
lunch aosp_RMX1941-userdebug
mka bacon -jX

# upload rom
rclone copy out/target/product/RMX1941/*UNOFFICIAL*.zip cirrus:RMX1941 -P  
