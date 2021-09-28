# Sync ROM
repo init --depth=1 --no-repo-verify -u https://github.com/Project-Fluid/manifest.git -b fluid-11 -g default,-device,-mips,-darwin,-notdefault
git clone https://github.com/deadline646/local_manifest.git --depth 1 -b FluidOS .repo/local_manifests
repo sync -c --no-clone-bundle --no-tags --optimized-fetch --prune --force-sync -j8

# Build ROM
source build/envsetup.sh
lunch fluid_juice-userdebug
export TZ=Asia/Kolkata
mka bacon

# Upload ROM
rclone copy out/target/product/$(grep unch $CIRRUS_WORKING_DIR/build_rom.sh -m 1 | cut -d ' ' -f 2 | cut -d _ -f 2 | cut -d - -f 1)/*.zip cirrus:$(grep unch $CIRRUS_WORKING_DIR/build_rom.sh -m 1 | cut -d ' ' -f 2 | cut -d _ -f 2 | cut -d - -f 1) -P
