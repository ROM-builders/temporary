# sync rom
repo init -u https://github.com/ArrowOS/android_manifest.git -b arrow-11.0 -g default,-device,-mips,-darwin,-notdefault
git clone https://github.com/androidgreek/local_manifest.git --depth=1 -b arrow .repo/local_manifests
repo sync -c --no-clone-bundle --no-tags --optimized-fetch --prune --force-sync -j8

# build rom
build/envsetup.sh
lunch arrow_devicefajita-userdebug
m otapackage

# upload rom
rclone copy out/target/product/fajita/arrow*.zip cirrus:fajita -P


