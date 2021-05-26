# sync rom
repo init --depth=1 -u https://github.com/sarthakroy2002/manifest-1 -b r-aosp -g default,-device,-mips,-darwin,-notdefault
git clone https://github.com/noobyysauraj/local_manifest.git --depth=1 .repo/local_manifests
repo sync -c --no-clone-bundle --no-tags --optimized-fetch --prune --force-sync -j8 || repo sync -c --no-clone-bundle --no-tags --optimized-fetch --prune --force-sync -j8

# build rom
source build/envsetup.sh
export SELINUX_IGNORE_NEVERALLOWS=true
export SKIP_ABI_CHECKS=true
export SKIP_API_CHECKS=true
export CUSTOM_BUILD_TYPE=UNOFFICIAL
brunch RMX2151 -j$(nproc --all)

# upload rom to rclone fast af
rclone copy out/target/product/RMX2151/*NEZUKO*.zip cirrus:$(grep unch $CIRRUS_WORKING_DIR/build_rom.sh -m 1 | cut -d _ -f 2 | cut -d - -f 1) -P

