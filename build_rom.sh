# sync rom
repo init --depth=1 -u https://github.com/Lineage-FE/manifest -b lineage-18.1 -g default,-device,-mips,-darwin,-notdefault
git clone https://github.com/baibhab34/local_manifest --depth 1 -b los .repo/local_manifests
repo sync -c --no-clone-bundle --no-tags --optimized-fetch --prune --force-sync -j8 || repo sync -c --no-clone-bundle --no-tags --optimized-fetch --prune --force-sync -j8

# build rom
source build/envsetup.sh
lunch lineage_RMX1805-userdebug
mka bacon

# upload rom
rclone copy out/target/product/RMX1805/*UNOFFICIAL*.zip cirrus:RMX1805 -P
