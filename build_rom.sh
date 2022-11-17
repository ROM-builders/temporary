# sync rom
repo init --depth=1 --no-repo-verify -u https://github.com/RiceDroid/android -b thirteen -g default,-mips,-darwin,-notdefault
git clone https://github.com/ZualoliconVN/local_manifest.git --depth 1 -b rice13-raphael .repo/local_manifests
repo sync -c --no-clone-bundle --no-tags --optimized-fetch --prune --force-sync -j8

# build rom
source build/envsetup.sh
export SELINUX_IGNORE_NEVERALLOWS=true
export KBUILD_BUILD_USER=ZualoliconVN
export KBUILD_BUILD_HOST=ZualoliconAndroidLab
export BUILD_USERNAME=ZualoliconVN
export BUILD_HOSTNAME=ZualoliconAndroidLab
export RELAX_USES_LIBRARY_CHECK=true
export SKIP_ABI_CHECKS=true
export BUILD_BROKEN_MISSING_REQUIRED_MODULES=true
export USE_DEXOPT=true
export RICE_CHIPSET := "Snapdragon™ 855 Gaming"
export TARGET_HAS_UDFPS := true
export TARGET_USE_PIXEL_FINGERPRINT := true
brunch aosp_raphael
export TZ=Asia/Kolkata #put before last build command

# upload rom (if you don't need to upload multiple files, then you don't need to edit next line)
rclone copy out/target/product/$(grep unch $CIRRUS_WORKING_DIR/build_rom.sh -m 1 | cut -d ' ' -f 2 | cut -d _ -f 2 | cut -d - -f 1)/*.zip cirrus:$(grep unch $CIRRUS_WORKING_DIR/build_rom.sh -m 1 | cut -d ' ' -f 2 | cut -d _ -f 2 | cut -d - -f 1) -P
