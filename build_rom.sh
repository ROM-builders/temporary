# sync rom
repo init --depth=1 -u git://github.com/ForkLineageOS/android.git -b lineage-18.1 -g default,-device,-mips,-darwin,-notdefault
git clone https://github.com/CPH1859/local_manifest.git --depth=1 .repo/local_manifests
repo sync -c --no-clone-bundle --no-tags --optimized-fetch --prune --force-sync -j$(nproc --all)

# build rom
source build/envsetup.sh
lunch lineage_CPH1859-userdebug
export SELINUX_IGNORE_NEVERALLOWS=true
export SKIP_ABI_CHECKS=true
export SKIP_API_CHECKS=true
mka bacon -j$(nproc --all)

# upload rom
rclone copy out/target/product/CPH1859/*UNOFFICIAL*.zip cirrus:$(grep unch $CIRRUS_WORKING_DIR/build_rom.sh -m 1 | cut -d _ -f 2 | cut -d - -f 1) -P

