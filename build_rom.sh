# sync rom
repo init --depth=1 -u https://github.com/StyxProject/manifest -b R -g default,-device,-mips,-darwin,-notdefault
git clone https://github.com/susandahal/local_manifest --depth 1 -b styx .repo/local_manifests
repo sync -c --no-clone-bundle --no-tags --optimized-fetch --prune --force-sync -j8

# build rom
source build/envsetup.sh
lunch styx_lavender-userdebug
m styx-ota

# upload rom
rclone copy out/target/product/lavender/styxOS-*.zip cirrus:lavender -P
