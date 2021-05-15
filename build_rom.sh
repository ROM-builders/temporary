# sync rom
repo init --depth=1 -u git://github.com/LineageOS/android.git -b lineage-16.0 -g default,-device,-mips,-darwin,-notdefault
git clone https://github.com/ItsVixano/local_manifest --depth 1 -b daisy-pie .repo/local_manifests
repo sync -c --no-clone-bundle --no-tags --optimized-fetch --prune --force-sync -j8 

# build rom
source build/envsetup.sh
lunch lineage_daisy-userdebug
make clean
make bacon

# upload rom
rclone copy out/target/product/daisy/lineage-16.0*.zip cirrus:giovannirn5 -P
