# sync rom
repo init --depth=1 --no-repo-verify -u https://github.com/PixelExperience/manifest -b thirteen -g default,-mips,-darwin,-notdefault
git clone https://github.com/soyabkhanmalek/local_manifest.git --depth 1 -b yunluo .repo/local_manifests
repo sync -c --no-clone-bundle --no-tags --optimized-fetch --prune --force-sync -j8

# build rom
. build/envsetup.sh
lunch aosp_yunluo-userdebug
export BUILD_BROKEN_MISSING_REQUIRED_MODULES=true
export ALLOW_MISSING_DEPENDENCIES=true
export CUSTOM_BUILD_TYPE=UNOFFICIAL-SoyabKhan
export BUILD_USERNAME=SoyabKhan
export BUILD_HOSTNAME=pc
export KBUILD_BUILD_USER=SoyabKhan
export KBUILD_BUILD_HOST=pc
export TZ=Asia/Kolkata

mka bacon

# upload rom (if you don't need to upload multiple files, then you don't need to edit next line)
rclone copy out/target/product/$(grep unch $CIRRUS_WORKING_DIR/build_rom.sh -m 1 | cut -d ' ' -f 2 | cut -d _ -f 2 | cut -d - -f 1)/*.zip cirrus:$(grep unch $CIRRUS_WORKING_DIR/build_rom.sh -m 1 | cut -d ' ' -f 2 | cut -d _ -f 2 | cut -d - -f 1) -P
