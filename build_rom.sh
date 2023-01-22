# sync rom
repo init --depth=1 --no-repo-verify -u repo init -u https://github.com/PixelOS-AOSP/manifest.git -b thirteen -g default,-mips,-darwin,-notdefault
git clone https://github.com/Monster7773/local_manifest_3 --depth 1 -b main .repo/local_manifests
repo sync -c --no-clone-bundle --no-tags --optimized-fetch --prune --force-sync -j8

# build rom
source build/envsetup.sh

lunch aosp_lava-userdebug
export ALLOW_MISSING_DEPENDENCIES=true
export KBUILD_BUILD_USER=deadaf
export KBUILD_BUILD_HOST=deadaf
export BUILD_USERNAME=deadaf
export BUILD_HOSTNAME=deadaf
export TZ=Asia/Kolkata #put before last build command

mka bacon 

# upload rom (if you don't need to upload multiple files, then you don't need to edit next line)
rclone copy out/target/product/$(grep unch $CIRRUS_WORKING_DIR/build_rom.sh -m 1 | cut -d ' ' -f 2 | cut -d _ -f 2 | cut -d - -f 1)/*.zip cirrus:$(grep unch $CIRRUS_WORKING_DIR/build_rom.sh -m 1 | cut -d ' ' -f 2 | cut -d _ -f 2 | cut -d - -f 1) -P
