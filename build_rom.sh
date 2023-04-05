# sync rom
repo init --depth=1 --no-repo-verify -u https://github.com/bananadroid/android_manifest.git -b 13 -g default,-mips,-darwin,-notdefault
git clone https://github.com/escobar1945/local_manifest.git --depth 1 -b main .repo/local_manifests
repo sync -c --no-clone-bundle --no-tags --optimized-fetch --prune --force-sync -j8

# build rom
source build/envsetup.sh

export SELINUX_IGNORE_NEVERALLOWS=true

export ALLOW_MISSING_DEPENDENCIES=true

export RELAX_USES_LIBRARY_CHECK=true

export BUILD_BROKEN_ELF_PREBUILT_PRODUCT_COPY_FILES=true

export BUILD_BROKEN_MISSING_REQUIRED_MODULES=true

export BUILD_BROKEN_VENDOR_PROPERTY_NAMESPACE=true

export BUILD_BROKEN_VERIFY_USES_LIBRARIES=true

export BUILD_BROKEN_USES_BUILD_COPY_HEADERS=true

export BUILD_BROKEN_DUP_RULES=true

export BUILD_USERNAME=escobar1945

export BUILD_HOSTNAME=esco-labs

export KBUILD_BUILD_NAME=escobar1945

export KBUILD_BUILD_HOST=esco-labs

export BUILD_BROKEN_CLANG_ASFLAGS=true

export BUILD_BROKEN_CLANG_CFLAGS=true
lunch banana_raphael-userdebug

export TZ=Asia/Dhaka #put before last build command
m banana

# upload rom (if you don't need to upload multiple files, then you don't need to edit next line)
rclone copy out/target/product/$(grep unch $CIRRUS_WORKING_DIR/build_rom.sh -m 1 | cut -d ' ' -f 2 | cut -d _ -f 2 | cut -d - -f 1)/*.zip cirrus:$(grep unch $CIRRUS_WORKING_DIR/build_rom.sh -m 1 | cut -d ' ' -f 2 | cut -d _ -f 2 | cut -d - -f 1) -P
