# sync rom 
repo init --depth=1 --no-repo-verify -u https://github.com/Project-Awaken/android_manifest -b triton -g default,-mips,-darwin,-notdefault
git clone https://github.com/abhishekfire08/manifest_local.git --depth 1 -b blazeGinkgo .repo/local_manifests
repo sync -c --no-clone-bundle --no-tags --optimized-fetch --prune --force-sync -j1 --fail-fast

# build rom 
source build/envsetup.sh
lunch awaken_ginkgo-userdebug
#export ALLOW_MISSING_DEPENDENCIES=true
export BUILD_BROKEN_USES_BUILD_COPY_HEADERS=true
export BUILD_BROKEN_DUP_RULES=true
#export TARGET_KERNEL_CLANG_VERSION=proton
export TZ=Asia/Kolkata #put before last build command
make bacon

# upload rom (if you don't need to upload multiple files, then you don't need to edit next line)
rclone copy out/target/product/$(grep unch $CIRRUS_WORKING_DIR/build_rom.sh -m 1 | cut -d ' ' -f 2 | cut -d _ -f 2 | cut -d - -f 1)/*.zip cirrus:$(grep unch $CIRRUS_WORKING_DIR/build_rom.sh -m 1 | cut -d ' ' -f 2 | cut -d _ -f 2 | cut -d - -f 1) -P

