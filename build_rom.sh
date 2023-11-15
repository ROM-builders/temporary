# sync rom
repo init --depth=1 --no-repo-verify -u https://github.com/Evolution-X/manifest -b udc -g default,-mips,-darwin,-notdefault
git clone https://github.com/rushiranpise/local_manifest.git --depth 1 -b evolos13 .repo/local_manifests
repo sync -c --no-clone-bundle --no-tags --optimized-fetch --prune --force-sync -j8

# build rom 2
source build/envsetup.sh
lunch evolution_chef-user
export TARGET_BOOT_ANIMATION_RES=1080
export TARGET_SUPPORTS_QUICK_TAP=true
export TARGET_USES_MINI_GAPPS=true
export TARGET_ENABLE_BLUR=true
export TARGET_USES_PICO_GAPPS=true
export KBUILD_BUILD_USER=rushiranpise
export KBUILD_BUILD_HOST=rushiranpise
export BUILD_USERNAME=rushiranpise
export BUILD_HOSTNAME=rushiranpise
export TZ=Asia/Kolkata #put before last build command
mka evolution

# upload rom (if you don't need to upload multiple files, then you don't need to edit next line)
rclone copy out/target/product/$(grep unch $CIRRUS_WORKING_DIR/build_rom.sh -m 1 | cut -d ' ' -f 2 | cut -d _ -f 2 | cut -d - -f 1)/*.zip cirrus:$(grep unch $CIRRUS_WORKING_DIR/build_rom.sh -m 1 | cut -d ' ' -f 2 | cut -d _ -f 2 | cut -d - -f 1) -P
#5
