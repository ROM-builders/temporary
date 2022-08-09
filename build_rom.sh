# sync rom
repo init --depth=1 --no-repo-verify -u https://github.com/RiceDroid/android -b twelve -g default,-mips,-darwin,-notdefault
git clone https://github.com/advandigital/local_manifest.git --depth 1 -b main .repo/local_manifests
repo sync -c --no-clone-bundle --no-tags --optimized-fetch --prune --force-sync -j8

# build rom
. build/envsetup.sh
export ALLOW_MISSING_DEPENDENCIES=true
export SELINUX_IGNORE_NEVERALLOWS=true
export WITH_GMS=false
export SUSHI_BOOTANIMATION=1080
export TARGET_BUILD_GRAPHENEOS_CAMERA=false
export TARGET_ENABLE_BLUR=false
export TARGET_HAS_UDFPS=false
export TARGET_SUPPORTS_QUICK_TAP=true
export TARGET_FACE_UNLOCK_SUPPORTED=true
export TZ=Asia/Makassar #put before last build command
brunch RMX1801

# upload rom (if you don't need to upload multiple files, then you don't need to edit next line)
rclone copy out/target/product/$(grep unch $CIRRUS_WORKING_DIR/build_rom.sh -m 1 | cut -d ' ' -f 2 | cut -d _ -f 2 | cut -d - -f 1)/*.zip cirrus:$(grep unch $CIRRUS_WORKING_DIR/build_rom.sh -m 1 | cut -d ' ' -f 2 | cut -d _ -f 2 | cut -d - -f 1) -P
