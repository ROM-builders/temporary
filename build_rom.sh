# sync rom
repo init --depth=1 -u git://github.com/LineageOS/android.git -b lineage-18.1 -g default,-device,-mips,-darwin,-notdefault
git clone https://github.com/sarthakroy2002/local_manifest.git --depth=1 .repo/local_manifests
repo sync -c --no-clone-bundle --no-tags --optimized-fetch --prune --force-sync -j$(nproc --all)

# build rom
source build/envsetup.sh
lunch lineage_RMX2050-userdebug
export SELINUX_IGNORE_NEVERALLOWS=true
export SKIP_ABI_CHECKS=true
export SKIP_API_CHECKS=true
mka bacon

# upload rom
rclone copy out/target/product/RMX2050/*UNOFFICIAL*.zip cirrus:RMX2050 -P
