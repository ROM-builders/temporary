# sync rom
repo init --depth=1 --no-repo-verify -u https://github.com/DerpFest-AOSP/manifest.git -b 13 -g default,-mips,-darwin,-notdefault
git clone https://github.com/gitclone-url/local_manifest.git --depth 1 -b DerpFest .repo/local_manifests
repo sync -c --force-sync --optimized-fetch --no-tags --no-clone-bundle --prune -j$(nproc --all)

# Extra CMD
export SKIP_ABI_CHECKS=true
export USE_CCACHE=1
export CCACHE_EXEC=/usr/bin/ccache
ccache -M 50G

# build rom
source build/envsetup.sh
lunch derp_sky-userdebug
export BUILD_USERNAME=Unknown
export BUILD_HOSTNAME=Cirrus 
export BUILD_BROKEN_MISSING_REQUIRED_MODULES=true
export TZ=Asia/Kolkata
mka derp

# upload rom
ROM_NAME=$(grep unch $CIRRUS_WORKING_DIR/build_rom.sh -m 1 | awk '{print $2}' | cut -d _ -f 2 | cut -d - -f 1)
rclone copy out/target/product/$ROM_NAME/*.zip cirrus:$ROM_NAME -P
