# sync rom
env
repo init -u https://github.com/NusantaraProject-ROM/android_manifest -b 11 --depth=1 -g default,-device,-mips,-darwin,-notdefault
git clone https://github.com/Fraschze97/local_manifest --depth 1 -b nusantara .repo/local_manifests
repo sync -c --no-clone-bundle --no-tags --optimized-fetch --prune --force-sync -j8


# build rom
source build/envsetup.sh
lunch nad_RMX1941-userdebug
export USE_GAPPS=true
export SELINUX_IGNORE_NEVERALLOWS=true
mka nad

# upload rom
rclone copy out/target/product/RMX1941/*.zip cirrus:RMX1941 -P
