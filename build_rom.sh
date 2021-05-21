# sync rom
repo init --depth=1 -u https://github.com/Wave-Project/manifest.git -b r -g default,-device,-mips,-darwin,-notdefault
git clone https://github.com/yashlearnpython/local_manifest.git --depth 1 -b wave-os .repo/local_manifests
repo sync -c --no-clone-bundle --no-tags --optimized-fetch --prune --force-sync -j8 || repo sync -c --no-clone-bundle --no-tags --optimized-fetch --prune --force-sync -j8

# build rom
source build/envsetup.sh
brunch mido

# upload rom
# If you need to upload json/multiple files too then put like this 'rclone copy out/target/product/mido/*.zip cirrus:mido -P && rclone copy out/target/product/mido/*.zip.json cirrus:mido -P'
rclone copy out/target/product/mido/*.zip cirrus:mido -P
