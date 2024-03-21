# sync rom
repo init --depth=1 --no-repo-verify -u https://github.com/PixelExperience/manifest.git -b thirteen -g default,-mips,-darwin,-notdefault
git clone https://github.com/Assunzain/local_manifest -b pixelplus .repo/local_manifests
repo sync -c --no-clone-bundle --no-tags --optimized-fetch --prune --force-sync -j8

# build rom
source build/envsetup.sh
lunch aosp_X01AD-userdebug
export BUILD_USERNAME=Assunzain
export BUILD_HOSTNAME=Assunzain
ALLOW_MISSING_DEPENDENCIES=true
export TZ=Asia/Jakarta #put before last build command
mka bacon

# upload rom (if you don't need to upload multiple files, then you don't need to edit next line)
rclone copy out/target/product/$(grep unch $CIRRUS_WORKING_DIR/build_rom.sh -m 1 | cut -d ' ' -f 2 | cut -d _ -f 2 | cut -d - -f 1)/*.zip cirrus:$(grep unch $CIRRUS_WORKING_DIR/build_rom.sh -m 1 | cut -d ' ' -f 2 | cut -d _ -f 2 | cut -d - -f 1) -P
