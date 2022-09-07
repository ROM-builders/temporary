# sync rom
repo init --depth=1 --no-repo-verify -u https://github.com/Evolution-X/manifest -b tiramisu -g default,-mips,-darwin,-notdefault
git clone https://github.com/hsx02/Local-Manifests.git --depth 1 -b evo13 .repo/local_manifests
repo sync -c --no-clone-bundle --no-tags --optimized-fetch --prune --force-sync -j8

# build rom
source build/envsetup.sh
lunch evolution_spes-userdebug
export TZ=Asia/Delhi #put before last build command
export SELINUX_IGNORE_NEVERALLOWS=true
export TARGET_BOOT_ANIMATION_RES=1080
export TARGET_FACE_UNLOCK_SUPPORTED=true
export TARGET_SUPPORTS_QUICK_TAP=false
export TARGET_INCLUDE_LIVE_WALLPAPERS=false
export TARGET_SUPPORTS_GOOGLE_RECORDER=false
export TARGET_SUPPORTS_CALL_RECORDING=true
export TARGET_SUPPORTS_NEXT_GEN_ASSISTANT=true
export TARGET_INCLUDE_STOCK_ARCORE=false
export TARGET_ENABLE_BLUR=true
export BUILD_BROKEN_MISSING_REQUIRED_MODULES=true
mka evolution

# upload rom (if you don't need to upload multiple files, then you don't need to edit next line)
rclone copy out/target/product/$(grep unch $CIRRUS_WORKING_DIR/build_rom.sh -m 1 | cut -d ' ' -f 2 | cut -d _ -f 2 | cut -d - -f 1)/*.zip cirrus:$(grep unch $CIRRUS_WORKING_DIR/build_rom.sh -m 1 | cut -d ' ' -f 2 | cut -d _ -f 2 | cut -d - -f 1) -P
