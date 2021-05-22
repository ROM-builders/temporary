# sync rom
repo init --depth=1 -u https://github.com/Wave-Project/manifest -b r -g default,-device,-mips,-darwin,-notdefault
git clone https://github.com/ad1tyas1ngh/local_manifest.git --depth 1 -b wave .repo/local_manifests
repo sync -c --no-clone-bundle --no-tags --optimized-fetch --prune --force-sync -j8 || repo sync -c --no-clone-bundle --no-tags --optimized-fetch --prune --force-sync -j8

# build rom
source build/envsetup.sh
lunch wave_RMX1801-userdebug
mka bacon

# upload rom
# If you need to upload json/multiple files too then put like this 'rclone copy out/target/product/mido/*.zip cirrus:mido -P && rclone copy out/target/product/mido/*.zip.json cirrus:mido -P'
rclone copy out/target/product/RMX1801/WaveOS*.zip cirrus:RMX1801 -P
