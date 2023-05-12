# sync rom
repo init --depth=1 --no-repo-verify -u https://github.com/bananadroid/android_manifest.git -b 13 -g default,-mips,-darwin,-notdefault --git-lfs
git clone https://github.com/UnsatifsedError/local_manifests.git --depth 1 -b banana .repo/local_manifests
repo sync -c --no-clone-bundle --no-tags --optimized-fetch --prune --force-sync -j8

# build rom
source build/envsetup.sh
lunch banana_sweet-userdebug
export TZ=Asia/Jakarta #put before last build command
export TARGET_SUPPORTS_64_BIT_APPS=true
export KBUILD_BUILD_USER=DjancoX
export KBUILD_BUILD_HOST=SemoxCoy
export BUILD_USERNAME=DjancoX
export BUILD_HOSTNAME=SemoxCoy
m banana

# upload rom (if you don't need to upload multiple files, then you don't need to edit next line)
rclone copy out/target/product/$(grep unch $CIRRUS_WORKING_DIR/build_rom.sh -m 1 | cut -d ' ' -f 2 | cut -d _ -f 2 | cut -d - -f 1)/*.zip cirrus:$(grep unch $CIRRUS_WORKING_DIR/build_rom.sh -m 1 | cut -d ' ' -f 2 | cut -d _ -f 2 | cut -d - -f 1) -P
