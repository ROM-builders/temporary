# sync rom
repo init --depth=1 --no-repo-verify -u git://github.com/DerpFest-11/manifest.git -b 11 -g default,-mips,-darwin,-notdefault
git clone https://github.com/nxzhuu47/c2_local_manifests.git --depth 1 -b master .repo/c2_local_manifests
repo sync -c --no-clone-bundle --no-tags --optimized-fetch --prune --force-sync -j8

# build rom
source build/envsetup.sh
lunch derp_rmx1941-userdebug
export BUILD_USER=nxzhuuu47
export BUILD_USERNAME=nxzhuuu47
export KBUILD_BUILD_USER=nxzhuuu47
export KBUILD_BUILD_USERNAME=nxzhuuu47
export BUILD_HOST=cirrus-ci
export BUILD_HOSTNAME=cirrus-ci
export SKIP_ABI_CHECKS=true
export SKIP_API_CHECKS=true

export TZ=Asia/Jakarta #put before last build command
mka derp

# upload rom (if you don't need to upload multiple files, then you don't need to edit next line)
rclone copy out/target/product/$(grep unch $CIRRUS_WORKING_DIR/build_rom.sh -m 1 | cut -d ' ' -f 2 | cut -d _ -f 2 | cut -d - -f 1)/*.zip cirrus:$(grep unch $CIRRUS_WORKING_DIR/build_rom.sh -m 1 | cut -d ' ' -f 2 | cut -d _ -f 2 | cut -d - -f 1) -P
