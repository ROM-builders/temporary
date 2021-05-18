
# sync rom
repo init --depth=1 -u git://github.com/DotOS/manifest.git -b dot11 -g default,-device,-mips,-darwin,-notdefault

git clone https://github.com/P-Salik/local_manifest --depth=1 -b DotOS .repo/local_manifests

repo sync -c --no-clone-bundle --no-tags --optimized-fetch --prune --force-sync -j$(nproc --all) || repo sync -c --no-clone-bundle --no-tags --optimized-fetch --prune --force-sync -j8


# build
source build/envsetup.sh
lunch dot_RMX1941-userdebug
export WITH_GAPPS=true
make bacon


# upload build
rclone copy out/target/product/RMX1941/*UNOFFICIAL*.zip cirrus:RMX1941 -P
