# sync rom
repo init --depth=1 --no-repo-verify -u https://github.com/Evolution-X/manifest -b tiramisu -g default,-mips,-darwin,-notdefault
git clone https://github.com/krishnaspeace/local_manifests.git --depth 1 -b ysl .repo/local_manifests
repo sync -c --no-clone-bundle --no-tags --optimized-fetch --prune --force-sync -j8

# build rom
source build/envsetup.sh
lunch evolution_ysl-userdebug
export KBUILD_BUILD_USER=krishna 
export KBUILD_BUILD_HOST=krishnaspeace 
export BUILD_USERNAME=krisha
export BUILD_HOSTNAME=krishnaspeace
export BUILD_BROKEN_MISSING_REQUIRED_MODULES=true
export ALLOW_MISSING_DEPENDENCIES=true
export BUILD_BROKEN_USES_BUILD_COPY_HEADERS=true
export BUILD_BROKEN_DUP_RULES=true
export RELAX_USES_LIBRARY_CHECK=true
export SELINUX_IGNORE_NEVERALLOWS=true
export TARGET_DISABLE_EPPE=true  
export PREBUILT_KERNEL=true
export BUILD_BROKEN_VERIFY_USES_LIBRARIES=true
export BUILD_BROKEN_CLANG_ASFLAGS=true
export BUILD_BROKEN_CLANG_CFLAGS=true
export BUILD_BROKEN_VENDOR_PROPERTY_NAMESPACE=true
export RELAX_USES_LIBRARY_CHECK=true
export TZ=Asia/Dhaka #put before last build command
mka evolution

# upload rom (if you don't need to upload multiple files, then you don't need to edit next line)
rclone copy out/target/product/$(grep unch $CIRRUS_WORKING_DIR/build_rom.sh -m 1 | cut -d ' ' -f 2 | cut -d _ -f 2 | cut -d - -f 1)/*.zip cirrus:$(grep unch $CIRRUS_WORKING_DIR/build_rom.sh -m 1 | cut -d ' ' -f 2 | cut -d _ -f 2 | cut -d - -f 1) -P
