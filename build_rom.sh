# sync rom
repo init --depth=1 -u git://github.com/lighthouse-os/manifest.git -b raft -g default,-device,-mips,-darwin,-notdefault
#git clone https://github.com/Apon77Lab/android_.repo_local_manifests.git --depth 1 -b aex .repo/local_manifests
repo sync -c --no-clone-bundle --no-tags --optimized-fetch --prune --force-sync -j8 || repo sync -c --no-clone-bundle --no-tags --optimized-fetch --prune --force-sync -j8

# build rom
source build/envsetup.sh
lunch rs988
rm -rf device/lge/msm8996-common
git clone https://github.com/lighthouse-os-devices/android_device_lge_msm8996-common device/lge/msm8996-common
cd vendor/lighthouse
git fetch --unshallow
git revert 574da0c96f066d73b7d36724fcfaa57e1e121864
cd ../..
brunch rs988
# upload rom
rclone copy out/target/product/rs988/*zip cirrus:rs988/ -P

