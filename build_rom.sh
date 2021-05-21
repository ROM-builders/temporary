# sync rom
repo init --depth=1 -u git://github.com/lighthouse-os/manifest.git -b raft -g default,-device,-mips,-darwin,-notdefault
git clone https://github.com/Stealth1226/local_manifest --depth 1 -b raft .repo/local_manifests
repo sync -c --no-clone-bundle --no-tags --optimized-fetch --prune --force-sync -j8 || repo sync -c --no-clone-bundle --no-tags --optimized-fetch --prune --force-sync -j8

# build rom
source build/envsetup.sh
brunch rs988
# upload rom
# If you need to upload json/multiple files too then put like this 'rclone copy out/target/product/mido/*.zip cirrus:mido -P && rclone copy out/target/product/mido/*.zip.json cirrus:mido -P'
rclone copy out/target/product/rs988/*OFFICIAL*.zip cirrus:rs988 -P
