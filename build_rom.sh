# sync rom
repo init --depth=1 --no-repo-verify -u https://github.com/PixelOS-AOSP/manifest.git -b twelve -g default,-mips,-darwin,-notdefault
git clone https://github.com/hklknz/Local-Manifests.git --depth 1 -b tissot-pos .repo/local_manifests
repo sync -c --no-clone-bundle --no-tags --optimized-fetch --prune --force-sync -j8

# build roms
source build/envsetup.sh
lunch aosp_tissot-userdebug
export TZ=Asia/Tokyo #put before last build command
export BUILD_BROKEN_DUP_RULES=true
export BUILD_BROKEN_MISSING_REQUIRED_MODULES=true
export BUILD_BROKEN_ELF_PREBUILT_PRODUCT_COPY_FILES=true
export BUILD_BROKEN_ENFORCE_SYSPROP_OWNER=true
export BUILD_BROKEN_VENDOR_PROPERTY_NAMESPACE=true
export RELAX_USES_LIBRARY_CHECK=true
RELAX_USES_LIBRARY_CHECK=true
export BUILD_USERNAME=LisaImai
export BUILD_HOSTNAME=Cloud
export KBUILD_BUILD_USER=Honoka
export KBUILD_BUILD_HOST=Cloud
mka bacon

# upload rom (if you don't need to upload multiple files, then you don't need to edit next line)
rclone copy out/target/product/$(grep unch $CIRRUS_WORKING_DIR/build_rom.sh -m 1 | cut -d ' ' -f 2 | cut -d _ -f 2 | cut -d - -f 1)/*.zip cirrus:$(grep unch $CIRRUS_WORKING_DIR/build_rom.sh -m 1 | cut -d ' ' -f 2 | cut -d _ -f 2 | cut -d - -f 1) -P
