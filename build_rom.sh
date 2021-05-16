# sync rom
repo init --depth=1 -u git://github.com/ResurrectionRemix/platform_manifest.git -b Q -g default,-device,-mips,-darwin,-notdefault
git clone https://github.com/harveyspectar/local_manifests.git --depth 1 .repo/local_manifests
repo sync -c --no-clone-bundle --no-tags --optimized-fetch --prune --force-sync -j8 || repo sync -c --no-clone-bundle --no-tags --optimized-fetch --prune --force-sync -j8

# build rom
source build/envsetup.sh
lunch rr_tissot-userdebug
make bacon


# upload rom
rclone copy out/target/product/tissot/RRQ*.zip cirrus:tissot -P
