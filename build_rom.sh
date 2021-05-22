# sync rom
repo init --depth=1 -u https://github.com/PixelExprience/manifest -b eleven-plus -g default,-device,-mips,-darwin,-notdefault
git clone https://github.com/kumarsujita6/local_manifests --depth 1 -b los .repo/local_manifests
repo sync -c --no-clone-bundle --no-tags --optimized-fetch --prune --force-sync -j8 || repo sync -c --no-clone-bundle --no-tags --optimized-fetch --prune --force-sync -j8

# build rom
source build/envsetup.sh
lunch aosp_RMX1801-userdebug
mka bacon

# upload rom
# If you need to upload json/multiple files too then put like this 'rclone copy out/target/product/mido/*.zip cirrus:mido -P && rclone copy out/target/product/mido/*.zip.json cirrus:mido -P'
rclone copy out/target/product/RMX1801/PixelExprience*RMX1801.zip cirrus:RMX1801 -P
