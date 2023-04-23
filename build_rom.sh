# sync rum
repo init --depth=1 --no-repo-verify -u https://github.com/DerpFest-AOSP/manifest -b 13 -g default,-mips,-darwin,-notdefault
git clone https://github.com/Idkanythin07/local_manifest --depth 1 -b derp .repo/local_manifests
repo sync -c --no-clone-bundle --no-tags --optimized-fetch --prune --force-sync -j8

# build rum

source build/envsetup.sh

lunch derp_RMX1941-userdebug

export BUILD_USER=IdkAnythin07
export BUILD_USERNAME=IdkAnythin07
export KBUILD_BUILD_USER=IdkAnythin07
export KBUILD_BUILD_USERNAME=IdkAnythin07
export BUILD_HOST=cirrus-ci
export BUILD_HOSTNAME=cirrus-ci

export SKIP_ABI_CHECKS=true
export SKIP_API_CHECKS=true
export TZ=Asia/Kolkata #put before last build command

mka derp

# upload rum (if you don't need to upload multiple files, then you don't need to edit next line)
rclone copy out/target/product/$(grep unch $CIRRUS_WORKING_DIR/build_rom.sh -m 1 | cut -d ' ' -f 2 | cut -d _ -f 2 | cut -d - -f 1)/*.zip cirrus:$(grep unch $CIRRUS_WORKING_DIR/build_rom.sh -m 1 | cut -d ' ' -f 2 | cut -d _ -f 2 | cut -d - -f 1) -P
