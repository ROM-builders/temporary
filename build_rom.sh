# sync rom
repo init --depth=1 -u git://github.com/Corvus-R/android_manifest.git -b 11 -g default,-device,-mips,-darwin,-notdefault
git clone https://github.com/sushmit1/mainfest_personal.git --depth 1 -b master .repo/local_manifests
repo sync -c --no-clone-bundle --no-tags --optimized-fetch --prune --force-sync -j8 || repo sync -c --no-clone-bundle --no-tags --optimized-fetch --prune --force-sync -j8

# build rom
. build/envsetup.sh
lunch corvus_ysl-userdebug
make corvus

# upload rom
rclone copy out/target/product/ysl/2021*.zip cirrus:ysl -P
