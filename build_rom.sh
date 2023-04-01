# sync rom
repo init --depth=1 --no-repo-verify -u https://github.com/PixelExtended/manifest.git -b trece -g default,-mips,-darwin,-notdefault
git clone https://github.com/acex69/local_manifest.git --depth 1 -b aosp .repo/local_manifests
repo sync -c --no-clone-bundle --no-tags --optimized-fetch --prune --force-sync -j4

# build rom
source build/envsetup.sh
lunch aosp_lancelot-userdebug
export BUILD_USERNAME=@raizel_69

export BUILD_HOSTNAME=@raizel69X
export TZ=Asia/Delhi #put before last build command
export SELINUX_IGNORE_NEVERALLOWS=true
mka bacon

# upload rom (if you don't need to upload multiple files, then you don't need to edit next line)
rclone copy out/target/product/$(grep unch $CIRRUS_WORKING_DIR/build_rom.sh -m 1 | cut -d ' ' -f 2 | cut -d _ -f 2 | cut -d - -f 1)/*.zip cirrus:$(grep unch $CIRRUS_WORKING_DIR/build_rom.sh -m 1 | cut -d ' ' -f 2 | cut -d _ -f 2 | cut -d - -f 1) -P
