# sync rom
repo init -u https://github.com/ShapeShiftOS/android_manifest.git -b android_11 -g default,-device,-mips,-darwin,-notdefault
git clone https://github.com/galanteria01/local_manifest.git --depth 1 -b ssos .repo/local_manifests
repo sync -c --no-clone-bundle --no-tags --optimized-fetch --prune --force-sync -j8 || repo sync -c --no-clone-bundle --no-tags --optimized-fetch --prune --force-sync -j8

# build rom
sudo apt update && sudo apt -y install cpio
source build/envsetup.sh
export BUILD_BROKEN_DUP_RULES=true
lunch ssos_violet-userdebug
brunch violet

# upload rom
# If you need to upload json/multiple files too then put like this 'rclone copy out/target/product/mido/*.zip cirrus:mido -P && rclone copy out/target/product/mido/*.zip.json cirrus:mido -P'
rclone copy out/target/product/violet/ShapeShiftOS*.zip cirrus:violet -P
