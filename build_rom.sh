# sync rom
repo init --depth=1 --no-repo-verify https://github.com/PixelExperience/manifest/tree/twelve-plus -g default,-mips,-darwin,-notdefault
git clone https://github.com/Raunak-sdm/local_manifest.git --depth 1 -b master .repo/local_manifests
repo sync -c --no-clone-bundle --no-tags --optimized-fetch --prune --force-sync -j8

# build rom
source build/envsetup.sh
#export
SELINUX_IGNORE_NEVERALLOWS=true
#export
ALLOW_MISSING_DEPENDENCIES=true
lunch aosp_rova-userdebug
export TZ=Asia/Delhi #put before last build command
mka bacon

# upload rom (if you don't need to upload multiple files, then you don't need to edit next line)
rclone copy out/target/product/$(grep unch $CIRRUS_WORKING_DIR/build_rom.sh -m 1 | cut -d ' ' -f 2 | cut -d _ -f 2 | cut -d - -f 1)/*.zip cirrus:$(grep unch $CIRRUS_WORKING_DIR/build_rom.sh -m 1 | cut -d ' ' -f 2 | cut -d _ -f 2 | cut -d - -f 1) -P
