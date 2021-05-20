# sync rom
repo init --depth=1 -u https://github.com/Project-Fluid/manifest.git -b fluid-11 -g default,-device,-mips,-darwin,-notdefault
git clone https://github.com/Shazu-xD/local_manifests.git --depth 1 -b main .repo/local_manifests
repo sync -c --no-clone-bundle --no-tags --optimized-fetch --prune --force-sync -j8 || repo sync -c --no-clone-bundle --no-tags --optimized-fetch --prune --force-sync -j8

# build rom
source build/envsetup.sh
lunch fluid_RMX1801-userdebug
mka bacon

# upload rom
rclone copy out/target/product/RMX1801/Fluid*.zip cirrus:RMX1801 -P
