# sync rom
repo init --depth=1 --no-repo-verify -u https://github.com/PixelOS-Pixelish/manifest -b twelve -g default,-mips,-darwin,-notdefault
git clone https://github.com/progcker/mlocal_manifest.git --depth 1 -b pix .repo/local_manifests
repo sync -c --no-clone-bundle --no-tags --optimized-fetch --prune --force-sync -j8

#build rom
# build rom
source build/envsetup.sh
lunch derp_CPH1859-userdebug
export BUILD_WITH_GAPPS=true
export ALLOW_MISSING_DEPENDENCIES=true
export SELINUX_IGNORE_NEVERALLOWS=true
export TZ=Asia/Kolkata #put before last build command
mka derp


# upload rom (if you don't need to upload multiple files, then you don't need to edit next line)
rclone copy out/target/product/$(grep unch $CIRRUS_WORKING_DIR/build_rom.sh -m 1 | cut -d ' ' -f 2 | cut -d _ -f 2 | cut -d - -f 1)/*.zip cirrus:$(grep unch $CIRRUS_WORKING_DIR/build_rom.sh -m 1 | cut -d ' ' -f 2 | cut -d _ -f 2 | cut -d - -f 1) -P
