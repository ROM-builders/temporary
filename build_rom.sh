# sync rom
repo init --depth=1 -u https://github.com/NezukoOS/manifest -b eleven -g default,-device,-mips,-darwin,-notdefault
git clone https://github.com/MLZ94/local_manifest -b master .repo/local_manifests
repo sync -c --no-clone-bundle --no-tags --optimized-fetch --prune --force-sync -j8 || repo sync -c --no-clone-bundle --no-tags --optimized-fetch --prune --force-sync -j8

# build rom
source build/envsetup.sh
lunch nezuko_X00QD-userdebug
mka bacon

# upload rom
rclone copy out/target/product/X00QD/NEZUKO*.zip cirrus:X00QD -P
