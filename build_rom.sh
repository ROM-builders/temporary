# sync rom
repo init --depth=1 --no-repo-verify -u https://github.com/PixelExperience/manifest -g default,-mips,-darwin,-notdefault
git clone https://github.com/vignesvicky2/local_manifest.git --depth 1 -b main .repo/local_manifests --depth 1 -b master .repo/local_manifests
repo sync -c -j$(nproc --all) --force-sync --no-clone-bundle --no-tags
# build rom
source build/envsetup.sh
lunch pixel_yogurt-user
export BUILD_BROKEN_MISSING_REQUIRED_MODULES=true
export TZ=Asia/Dhaka
mka bacon

# upload rom (if you don't need to upload multiple files, then you don't need to edit next line)
rclone copy out/target/product/$(grep unch $CIRRUS_WORKING_DIR/build_rom.sh -m 1 | cut -d ' ' -f 2 | cut -d _ -f 2 | cut -d - -f 1)/*.zip cirrus:$(grep unch $CIRRUS_WORKING_DIR/build_rom.sh -m 1 | cut -d ' ' -f 2 | cut -d _ -f 2 | cut -d - -f 1) -P
