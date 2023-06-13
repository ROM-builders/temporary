# sync rom
repo init --no-repo-verify --depth=1 -u https://github.com/pixeldust-project-caf/manifest -b tartufo-qpr2 -g default,-mips,-darwin,-notdefault
git clone https://github.com/GeneralFrosa/local_manifest.git --depth 1 -b PixelDust-rmx3371 .repo/local_manifests
repo sync -c --no-clone-bundle --no-tags --optimized-fetch --prune --force-sync -j8

# build rom
source build/envsetup.sh
lunch aosp_rmx3371-user
export TZ=Asia/Batam #put before last build command
mka bacon

# upload rom (if you don't need to upload multiple files, then you don't need to edit next line)
rclone copy out/target/product/$(grep unch $CIRRUS_WORKING_DIR/build_rom.sh -m 1 | cut -d ' ' -f 2 | cut -d _ -f 2 | cut -d - -f 1)/*.zip cirrus:$(grep unch $CIRRUS_WORKING_DIR/build_rom.sh -m 1 | cut -d ' ' -f 2 | cut -d _ -f 2 | cut -d - -f 1) -P
