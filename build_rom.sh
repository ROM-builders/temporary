# sync rom
repo init --depth=1 -u git://github.com/Havoc-OS/android_manifest.git -b eleven -g default,-device,-mips,-darwin,-notdefault
git clone https://github.com/boedhack/local_manifest.git --depth=1 -b havoc .repo/local_manifests
repo sync -c --no-clone-bundle --no-tags --optimized-fetch --prune --force-sync -j8 || repo sync -c --no-clone-bundle --no-tags --optimized-fetch --prune --force-sync -j8

# build rom
. build/envsetup.sh
lunch havoc_mojito-user
brunch mojito

# upload rom
# If you need to upload json/multiple files too then put like this 'rclone copy out/target/product/mido/*.zip cirrus:mido -P && rclone copy out/target/product/mido/*.zip.json cirrus:mido -P'
rclone copy out/target/product/mojito/Havoc-OS*.zip cirrus:mojito -P



