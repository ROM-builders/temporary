# sync rom
repo init -u https://github.com/CherishOS/android_manifest.git -b eleven --depth=1 -g default,-device,-mips,-darwin,-notdefault
git clone https://github.com/Yasundram/local_manifest --depth 1 -b aex .repo/local_manifests
repo sync -c -j$(nproc --all) --force-sync --no-clone-bundle --no-tags

# build rom
. build/envsetup.sh
export CHERISH_MAINTAINER=Sundram 
export CHERISH_NONGAPPS=true
 brunch RMX1941-userdebug

# upload rom
rclone copy out/target/product/RMX1941/*UNOFFICIAL*.zip cirrus:RMX1941 -P
