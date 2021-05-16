# sync rom
repo init -u git://github.com/TenX-OS/manifest_TenX -b eleven -g default,-device,-mips,-darwin,-notdefault
git clone https://github.com/thebuildbomt/local_manifest.git --depth 1 -b los .repo/local_manifests
repo sync -c --no-clone-bundle --no-tags --optimized-fetch --prune --force-sync -j8 || repo sync -c --no-clone-bundle --no-tags --optimized-fetch --prune --force-sync -j8

# build rom
source build/envsetup.sh
lunch aosl_RMX1801-userdebug
make bacon -j8

# upload rom
rclone copy out/target/product/RMX1801/tenx*.zip cirrus:RMX1801 -P
