# sync rum (5th try)
repo init --depth=1 --no-repo-verify -u https://github.com/PixelExperience/manifest.git -b thirteen -g default,-mips,-darwin,-notdefault
git clone https://github.com/IdkAnythin07/local_manifest.git --depth 1 -b Pixel_exp .repo/local_manifests
repo sync -c --no-clone-bundle --no-tags --optimized-fetch --prune --force-sync -j8

# bleed rum
source build/envsetup.sh
lunch aosp_RMX1941-userdebug

export BUILD_USER=IdkAnythin07
export BUILD_USERNAME=IdkAnythin07
export KBUILD_BUILD_USER=IdkAnythin07
export KBUILD_BUILD_USERNAME=IdkAnythin07
export BUILD_HOST=cirrus-ci
export BUILD_HOSTNAME=cirrus-ci
export SKIP_ABI_CHECKS=true
export SKIP_API_CHECKS=true

export TZ=Asia/Kolkata #put b4 last build command
mka bacon

# upload rum (if you don't need to upload multiple files, then you don't need to edit next line)
rclone copy out/target/product/$(grep unch $CIRRUS_WORKING_DIR/build_rom.sh -m 1 | cut -d ' ' -f 2 | cut -d _ -f 2 | cut -d - -f 1)/*.zip cirrus:$(grep unch $CIRRUS_WORKING_DIR/build_rom.sh -m 1 | cut -d ' ' -f 2 | cut -d _ -f 2 | cut -d - -f 1) -P
