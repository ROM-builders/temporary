# sync rom
repo init --depth=1 --no-repo-verify -u https://github.com/descendant-xi/manifests.git -b eleven-staging -g default,-device,-mips,-darwin,-notdefault
git clone https://github.com/Radeon790/local_manifests.git --depth 1 -b r11 .repo/local_manifests
repo sync -c --no-clone-bundle --no-tags --optimized-fetch --prune --force-sync -j8

# obb fix
cd frameworks/native && git fetch https://github.com/phhusson/platform_frameworks_native android-11.0.0_r28-phh && git cherry-pick cc94e422c0a8b2680e7f9cfc391b2b03a56da765
cd ../..

# build rom
source build/envsetup.sh
lunch descendant_RMX1831-userdebug
mka descendant

# upload rom (if you don't need to upload multiple files, then you don't need to edit next line)
rclone copy out/target/product/$(grep unch $CIRRUS_WORKING_DIR/build_rom.sh -m 1 | cut -d ' ' -f 2 | cut -d _ -f 2 | cut -d - -f 1)/*.zip cirrus:$(grep unch $CIRRUS_WORKING_DIR/build_rom.sh -m 1 | cut -d ' ' -f 2 | cut -d _ -f 2 | cut -d - -f 1) -P
