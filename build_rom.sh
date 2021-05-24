# sync rom
repo init --depth=1 -u https://github.com/Havoc-OS/android_manifest.git -b eleven
git clone https://github.com/Fraschze97/local_manifest --depth=1 -b main .repo/local_manifests
repo sync -c --no-clone-bundle --no-tags --optimized-fetch --prune --force-sync -j8 || repo sync -c --no-clone-bundle --no-tags --optimized-fetch --prune --force-sync -j8

# build rom
. build/envsetup.sh
lunch havoc_RMX1945-userdebug
brunch RMX1941

# upload rom
# If you need to upload json/multiple files too then put like this 'rclone copy out/target/product/mido/*.zip cirrus:mido -P && rclone copy out/target/product/mido/*.zip.json cirrus:mido -P'
rclone copy out/target/product/RMX1941/*.zip cirrus:RMX1941 -P
