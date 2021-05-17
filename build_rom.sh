# sync rom
repo init --depth=1 -u https://github.com/HyconOS/manifest.git  -b eleven -g default,-device,-mips,-darwin,-notdefault
git clone https://github.com/Dustxyz/personal_manifest.git --depth 1 -b master .repo/local_manifests
repo sync -c --no-clone-bundle --no-tags --optimized-fetch --prune --force-sync -j8 || repo sync -c --no-clone-bundle --no-tags --optimized-fetch --prune --force-sync -j8

# build rom
source build/envsetup.sh
lunch aosp_ysl-userdebug
mka bacon 

# upload rom
rclone copy out/target/product/mido/*.zip cirrus:ysl -P
