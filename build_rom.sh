# sync rom

repo init --depth=1 --no-repo-verify -u https://github.com/PixelExperience/manifest.git -b thirteen-plus -g default,-mips,-darwin,-notdefault
git clone https://github.com/omansh-krishn/local_manifest --depth 1 -b pixelexperience-13 .repo/local_manifests
repo sync -c --no-clone-bundle --no-tags --optimized-fetch --prune --force-sync -j8
# build rom
#retry[2]
source build/envsetup.sh
export TARGET_GAPPS_ARCH=arm64
export TARGET_KERNEL_CLANG_VERSION=clang-r450784d
export TARGET_KERNEL_CLANG_PATH=$(pwd)/prebuilts/clang/host/linux-x86/${TARGET_KERNEL_CLANG_VERSION}
export TARGET_KERNEL_CROSS_COMPILE_PREFIX=${TARGET_KERNEL_CLANG_PATH}/bin/aarch64-linux-gnu-
export TARGET_KERNEL_CROSS_COMPILE_ARM32_PREFIX=${TARGET_KERNEL_CLANG_PATH}/bin/arm-linux-gnueabi-
export TARGET_KERNEL_LLVM_BINUTILS=false
export BUILD_BROKEN_MISSING_REQUIRED_MODULES=true
export BUILD_USERNAME=OmanshKrishn
export BUILD_HOSTNAME=ubuntu
export KBUILD_BUILD_USER=OmanshKrishn
export KBUILD_BUILD_HOST=ubuntu
export ALLOW_MISSING_DEPENDENCIES=true

lunch aosp_santoni-userdebug
export TZ=Asia/Kolkata #put before last build command
mka bacon

# upload rom (if you don't need to upload multiple files, then you don't need to edit next line)
rclone copy out/target/product/$(grep unch $CIRRUS_WORKING_DIR/build_rom.sh -m 1 | cut -d ' ' -f 2 | cut -d _ -f 2 | cut -d - -f 1)/*.zip cirrus:$(grep unch $CIRRUS_WORKING_DIR/build_rom.sh -m 1 | cut -d ' ' -f 2 | cut -d _ -f 2 | cut -d - -f 1) -P
