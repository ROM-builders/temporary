# sync rom
repo init --depth=1 --no-repo-verify -u https://github.com/CherishOS/android_manifest.git -b tiramisu -g default,-mips,-darwin,-notdefault
git clone https://github.com/ZualoliconVN/local_manifest.git --depth 1 -b cherish .repo/local_manifests
repo sync -c --no-clone-bundle --no-tags --optimized-fetch --prune --force-sync -j8

# build rom
source build/envsetup.sh
export SELINUX_IGNORE_NEVERALLOWS=true
export KBUILD_BUILD_USER=ZualoliconVN
export KBUILD_BUILD_HOST=Zualolicon-Android-Lab
export BUILD_USERNAME=ZualoliconVN
export BUILD_HOSTNAME=Zualolicon-Android-Lab
export RELAX_USES_LIBRARY_CHECK=true
export SKIP_ABI_CHECKS=true
export USE_DEXOPT=true
export CHERISH_VANILLA=true
export TZ=Asia/Kolkata #put before last build command
brunch r5x

# upload rom (if you don't need to upload multiple files, then you don't need to edit next line)
rclone copy out/target/product/$(grep unch $CIRRUS_WORKING_DIR/build_rom.sh -m 1 | cut -d ' ' -f 2 | cut -d _ -f 2 | cut -d - -f 1)/*.zip cirrus:$(grep unch $CIRRUS_WORKING_DIR/build_rom.sh -m 1 | cut -d ' ' -f 2 | cut -d _ -f 2 | cut -d - -f 1) -P
