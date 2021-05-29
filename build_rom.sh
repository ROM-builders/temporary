# sync rom
repo init -u https://github.com/descendant-xi/manifests.git -b eleven-staging --depth=1 -g default,-device,-mips,-darwin,-notdefault

git clone https://github.com/Yasundram/local_manifest --depth 1 -b main .repo/local_manifests


repo sync -c --no-clone-bundle --no-tags --optimized-fetch --prune --force-sync -j8 || repo sync -c --no-clone-bundle --no-tags --optimized-fetch --prune --force-sync -j8

# build rom
source build/envsetup.sh
lunch descendant_RMX1941-userdebug
mka descendant


# upload rom
rclone copy out/target/product/RMX1941/*UNOFFICIAL*.zip cirrus:RMX1941 -P
