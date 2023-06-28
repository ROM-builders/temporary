# sync rom
repo init --depth=1 --no-repo-verify -u https://github.com/CipherOS/android_manifest.git -b thirteen -g default,-mips,-darwin,-notdefault
git clone https://github.com/nullptr03/local_manifest.git --depth 1 -b cipher .repo/local_manifests
repo sync -c --no-clone-bundle --no-tags --optimized-fetch --prune --force-sync -j8

# wen stop
source build/envsetup.sh
lunch cipher_merlinx-userdebug
export BUILD_HOSTNAME=Andy
export BUILD_USERNAME=Andy
export KBUILD_USERNAME=Andy
export KBUILD_HOSTNAME=Andy
export TARGET_KERNEL_CLANG_VERSION=proton-clang
export TARGET_KERNEL_CLANG_PATH=$(pwd)/prebuilts/clang/host/linux-x86/${TARGET_KERNEL_CLANG_VERSION}
export TARGET_KERNEL_CROSS_COMPILE_PREFIX=${TARGET_KERNEL_CLANG_PATH}/bin/aarch64-linux-gnu-
export TARGET_KERNEL_CROSS_COMPILE_ARM32_PREFIX=${TARGET_KERNEL_CLANG_PATH}/bin/arm-linux-gnueabi-
export TARGET_KERNEL_LLVM_BINUTILS=false
export ALLOW_MISSING_DEPENDENCIES=true
export TZ=Asia/Makassar
mka bacon

# upload rom (if you don't need to upload multiple files, then you don't need to edit next line)
rclone copy out/target/product/$(grep unch $CIRRUS_WORKING_DIR/build_rom.sh -m 1 | cut -d ' ' -f 2 | cut -d _ -f 2 | cut -d - -f 1)/*.zip cirrus:$(grep unch $CIRRUS_WORKING_DIR/build_rom.sh -m 1 | cut -d ' ' -f 2 | cut -d _ -f 2 | cut -d - -f 1) -P
