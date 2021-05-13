# sync rom
repo init --depth=1 -u git://github.com/AOSiP/platform_manifest.git -b eleven -g default,-device,-mips,-darwin,-notdefault
git clone  --depth 1 https://github.com/flashokiller/mainfest_personal -b master .repo/local_manifests
repo sync -c --no-clone-bundle --no-tags --optimized-fetch --prune --force-sync -j8 

# build rom
source build/envsetup.sh
export ALLOW_MISSING_DEPENDENCIES=true
lunch aosip_ysl-user
time m kronic

# upload rom
rclone copy out/target/product/ysl/AOSIP*.zip cirrus:ysl -P
