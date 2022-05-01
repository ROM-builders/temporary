# sync rom
repo init --depth=1 --no-repo-verify -u https://github.com/AospExtended/manifest -b 12.1.x -g default,-mips,-darwin,-notdefault
git clone https://github.com/rushiranpise/local_manifest.git --depth 1 -b aex .repo/local_manifests
repo sync -c --no-clone-bundle --no-tags --optimized-fetch --prune --force-sync -j8

# build rom
source build/envsetup.sh
lunch aosp_chef-userdebug
export KBUILD_BUILD_USER=rushiranpise
export KBUILD_BUILD_HOST=rushiranpise
export BUILD_USERNAME=rushiranpise
export BUILD_HOSTNAME=rushiranpise
export SELINUX_IGNORE_NEVERALLOWS=true
export WITH_GAPPS=true
export TZ=Asia/Kolkata #put before last build command
m otapackage

# upload rom (if you don't need to upload multiple files, then you don't need to edit next line)
# rclone copy out/target/product/$(grep unch $CIRRUS_WORKING_DIR/build_rom.sh -m 1 | cut -d ' ' -f 2 | cut -d _ -f 2 | cut -d - -f 1)/*.zip cirrus:$(grep unch $CIRRUS_WORKING_DIR/build_rom.sh -m 1 | cut -d ' ' -f 2 | cut -d _ -f 2 | cut -d - -f 1) -P
rclone copy out/target/product/chef/*.zip cirrus:chef/aex -P

# 3
