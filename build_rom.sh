# sync rom
repo init --depth=1 -u https://github.com/NezukoOS/manifest.git -b eleven -g default,-device,-mips,-darwin,-notdefault
git clone https://github.com/noobyysauraj/local_manifest.git --depth=1 .repo/local_manifests
repo sync -c --no-clone-bundle --no-tags --optimized-fetch --prune --force-sync -j8 || repo sync -c --no-clone-bundle --no-tags --optimized-fetch --prune --force-sync -j8

# build rom
source build/envsetup.sh
lunch nezuko_RMX2151-userdebug
export SELINUX_IGNORE_NEVERALLOWS=true
export SKIP_ABI_CHECKS=true
export SKIP_API_CHECKS=true
export CUSTOM_BUILD_TYPE=UNOFFICIAL
mka bacon -j$(nproc --all)

# upload rom to rclone
rclone copy out/target/product/RMX2151/*NEZUKO*.zip cirrus:$(grep unch $CIRRUS_WORKING_DIR/build_rom.sh -m 1 | cut -d _ -f 2 | cut -d - -f 1) -P

