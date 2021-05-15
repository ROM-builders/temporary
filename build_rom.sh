# sync rom
repo init --depth=1 -u https://github.com/LineageOS/android -b lineage-18.1 -g default,-device,-mips,-darwin,-notdefault
git clone https://github.com/baibhab34/local_manifest --depth 1 -b los .repo/local_manifests
repo sync -c --no-clone-bundle --no-tags --optimized-fetch --prune --force-sync -j8 

# build rom
source build/envsetup.sh
lunch lineage_RMX1805-userdebug
make clean
mka bacon

# upload rom
rclone copy out/target/product/RMX1805/lineage*RMX1805.zip cirrus:RMX1805 -P
