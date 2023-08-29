# sync rom
repo init --depth=1 --git-lfs --no-repo-verify -u https://github.com/VoltageOS/manifest.git -b 13 -g default,-mips,-darwin,-notdefault
git clone https://github.com/Shakib-BD/local_manifest.git --depth 1 -b voltage-13 .repo/local_manifests
repo sync -c --no-clone-bundle --no-tags --optimized-fetch --prune --force-sync -j8

# build rom
. build/envsetup.sh
export KBUILD_BUILD_USER=Shakib
export KBUILD_BUILD_HOST=Shakib
export BUILD_USERNAME=Shakib
export BUILD_HOSTNAME=Shakib
export RELAX_USES_LIBRARY_CHECK=true
export SKIP_ABI_CHECKS=true
export BUILD_BROKEN_MISSING_REQUIRED_MODULES=true
export USE_DEXOPT=true
export SELINUX_IGNORE_NEVERALLOWS=true
export BUILD_BROKEN_USES_BUILD_COPY_HEADERS=true
export BUILD_BROKEN_VERIFY_USES_LIBRARIES=true
export BUILD_BROKEN_DUP_RULES=true
export BUILD_BROKEN_CLANG_ASFLAGS=true
export BUILD_BROKEN_CLANG_CFLAGS=true
export BUILD_BROKEN_VENDOR_PROPERTY_NAMESPACE=true
export RELAX_USES_LIBRARY_CHECK=true
export TZ=Asia/Dhaka ##put before last build command
brunch merlinx

# upload rom (if you don't need to upload multiple files, then you don't need to edit next line)
rclone copy out/target/product/$(grep unch $CIRRUS_WORKING_DIR/build_rom.sh -m 1 | cut -d ' ' -f 2 | cut -d _ -f 2 | cut -d - -f 1)/*.zip cirrus:$(grep unch $CIRRUS_WORKING_DIR/build_rom.sh -m 1 | cut -d ' ' -f 2 | cut -d _ -f 2 | cut -d - -f 1) -P
