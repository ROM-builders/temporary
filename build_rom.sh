# sync rom
repo init --depth=1 -u git://github.com/AospExtended/manifest.git -b 11.x -g default,-device,-mips,-darwin,-notdefault
git clone https://github.com/ECr34T1v3/android_.repo_local_manifests.git --depth 1 -b main .repo/local_manifests
repo sync -c --no-clone-bundle --no-tags --optimized-fetch --prune --force-sync -j8 

# build rom
source build/envsetup.sh
lunch aosp_beyond0lte-userdebug
m aex

# upload rom
rclone copy out/target/product/beyond0lte/AospExtended*.zip cirrus:beyond0lte -P
