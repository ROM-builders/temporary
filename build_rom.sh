# sync rom
repo init --depth=1 --no-repo-verify -u https://github.com/ShapeShiftOS/android_manifest -b android_13 -g default,-mips,-darwin,-notdefault
git clone https://github.com/abhishekfire08/manifest_local.git --depth 1 -b blazeGinkgo .repo/local_manifests
repo sync -c --no-clone-bundle --no-tags --optimized-fetch --prune --force-sync -j8

# build rom
source build/envsetup.sh
lunch ssos_ginkgo-userdebug
export BUILD_USERNAME=xyz_abhishek
export BUILD_HOSTNAME=xyz_abhishek
#export ALLOW_MISSING_DEPENDENCIES=true
#export TARGET_KERNEL_CLANG_VERSION=proton
export TZ=Asia/Kolkata #put before last build command
mka bacon

# upload rom (if you don't need to upload multiple files, then you don't need to edit next line)
rclone copy out/target/product/$(grep unch $CIRRUS_WORKING_DIR/build_rom.sh -m 1 | cut -d ' ' -f 2 | cut -d _ -f 2 | cut -d - -f 1)/*.zip cirrus:$(grep unch $CIRRUS_WORKING_DIR/build_rom.sh -m 1 | cut -d ' ' -f 2 | cut -d _ -f 2 | cut -d - -f 1) -P
