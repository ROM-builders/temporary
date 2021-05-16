# sync rom
repo init --depth=1 -u git://github.com/crdroidandroid/android.git -b 11.0 -g default,-device,-mips,-darwin,-notdefault
git clone https://github.com/boedhack/local_manifest.git --depth 1 -b 11.0 .repo/local_manifests
repo sync -c --no-clone-bundle --no-tags --optimized-fetch --prune --force-sync -j8 || repo sync -c --no-clone-bundle --no-tags --optimized-fetch --prune --force-sync -j8

# build rom
. build/envsetup.sh
lunch lineage_mojito-userdebug
export SKIP_API_CHECKS=true
export SKIP_ABI_CHECKS=true
mka bacon

# upload rom
rclone copy out/target/product/mojito/crDroidandroid*.zip cirrus:mojito -P
