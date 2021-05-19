# sync rom
repo init --depth=1 -u git://github.com/PixelExperience/manifest.git -b eleven -g default,-device,-mips,-darwin,-notdefault
git clone https://github.com/ECr34T1v3/android_.repo_local_manifests.git --depth 1 -b beyond0-pe .repo/local_manifests
repo sync -c --no-clone-bundle --no-tags --optimized-fetch --prune --force-sync -j8 || repo sync -c --no-clone-bundle --no-tags --optimized-fetch --prune --force-sync -j8

# build rom
. build/envsetup.sh
lunch aosp_beyond0lte-userdebug
mka bacon

# upload rom
rclone copy out/target/product/beyond0lte/*.zip cirrus:beyond0lte -P
