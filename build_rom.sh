# sync rom
repo init --depth=1 -u git://github.com/PixelExperience/manifest.git -b eleven-plus -g default,-device,-mips,-darwin,-notdefault
git clone https://github.com/kumarsujita6/local_manifests.git --depth 1 -b aex .repo/local_manifests
repo sync -c --no-clone-bundle --no-tags --optimized-fetch --prune --force-sync -j8 || repo sync -c --no-clone-bundle --no-tags --optimized-fetch --prune --force-sync -j8

# build rom
source build/envsetup.sh
lunch aosp_RMX1801-userdebug
mka bacon

# upload rom
# If you need to upload json/multiple files too then put like this 'rclone copy out/target/product/mido/*.zip cirrus:mido -P && rclone copy out/target/product/mido/*.zip.json cirrus:mido -P'
rclone copy out/target/product/RMX1801/RMX1801*.zip cirrus:mido -P
