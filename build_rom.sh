# sync rom
repo init --depth=1 --no-repo-verify -u https://github.com/hentaiOS/platform_manifest -b Rika -g default,-device,-mips,-darwin,-notdefault
git clone https://github.com/Shazu-xD/local_manifest.git --depth 1 -b Hentai .repo/local_manifests
repo sync -c --no-clone-bundle --no-tags --optimized-fetch --prune --force-sync -j8

# build rom
source build/envsetup.sh
lunch hentai_RMX1801-userdebug
make otapackage -jX

# upload rom
rclone copy out/target/product/RMX1801/*2021*.zip cirrus:RMX1801 -P
