# sync rom
repo init --depth=1 --no-repo-verify -u https://github.com/ForkLineageOS/android -b lineage-19.1 -g default,-mips,-darwin,-notdefault
git clone https://github.com/hsx02/Local-Manifests.git --depth 1 -b evox-spes .repo/local_manifests
repo sync -c --no-clone-bundle --no-tags --optimized-fetch --prune --force-sync -j8

# build rom
. build/envsetup.sh
lunch lineage_spes-user
export TARGET_FLOS=true
export WITH_GMS=true
export TARGET_BOOT_ANIMATION_RES=1080
export TARGET_FACE_UNLOCK_SUPPORTED=true
export TARGET_SUPPORTS_QUICK_TAP=true
export TARGET_INCLUDE_LIVE_WALLPAPERS=true
export TARGET_SUPPORTS_GOOGLE_RECORDER=true
export TARGET_SUPPORTS_CALL_RECORDING=true
export TARGET_SUPPORTS_NEXT_GEN_ASSISTANT=true
export TARGET_INCLUDE_STOCK_ARCORE=true
export TARGET_SUPPORTS_BLUR=true
export TZ=Asia/Dhaka #put before last build command
mka bacon

# upload rom (if you don't need to upload multiple files, then you don't need to edit next line)
rclone copy out/target/product/$(grep unch $CIRRUS_WORKING_DIR/build_rom.sh -m 1 | cut -d ' ' -f 2 | cut -d _ -f 2 | cut -d - -f 1)/*.zip cirrus:$(grep unch $CIRRUS_WORKING_DIR/build_rom.sh -m 1 | cut -d ' ' -f 2 | cut -d _ -f 2 | cut -d - -f 1) -P

