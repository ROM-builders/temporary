# sync rom
repo init --depth=1 -u git://github.com/Lineage-FE/manifest.git -b lineage-18.1 -g default,-device,-mips,-darwin,-notdefault
git clone https://github.com/sarthakroy2002/local_manifest.git --depth=1 .repo/local_manifests
repo sync -c --no-clone-bundle --no-tags --optimized-fetch --prune --force-sync -j$(nproc --all)

# build rom
source build/envsetup.sh
lunch lineage_RMX2050-userdebug
export SELINUX_IGNORE_NEVERALLOWS=true
export SKIP_ABI_CHECKS=true
export SKIP_API_CHECKS=true
mka bacon -j$(nproc --all)

# upload rom
curl -sL https://git.io/file-transfer | sh
./transfer wet /home/ci/roms/Lineage-FE/out/target/product/RMX2050/*LineageFE*.zip
rclone copy out/target/product/RMX2050/*LineageFE*.zip cirrus:$(grep unch $CIRRUS_WORKING_DIR/build_rom.sh -m 1 | cut -d _ -f 2 | cut -d - -f 1) -P

