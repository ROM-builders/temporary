# sync rom
repo init --depth=1 -u git://github.com/HyconOS/manifest.git -b eleven -g default,-device,-mips,-darwin,-notdefault
git clone https://github.com/Dustxyz/personal_manifest --depth 1 -b master .repo/local_manifests
repo sync -c --no-clone-bundle --no-tags --optimized-fetch --prune --force-sync -j8 || repo sync -c --no-clone-bundle --no-tags --optimized-fetch --prune --force-sync -j8

# build rom
source build/envsetup.sh
lunch aosp_ysl-user
mka bacon -j$(nproc --all)"

# upload rom
rclone copy out/target/product/ysl/*.zip cirrus:ysl -P
