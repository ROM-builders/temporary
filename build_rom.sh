# sync rom
repo init --depth=1 --no-repo-verify -u https://github.com/BlissRoms/platform_manifest.git -b typhoon --git-lfs -g default,-mips,-darwin,-notdefault
git clone https://github.com/TasinAyon/android_.repo_local_manifests --depth 1 -b main .repo/local_manifests
repo sync -c --no-clone-bundle --no-tags --optimized-fetch --prune --force-sync -j8

# build rom
source build/envsetup.sh
lunch bliss_begonia-userdebug
export KBUILD_BUILD_USER=MediaTek
export KBUILD_BUILD_HOST=MediaTek
export BUILD_USERNAME=MediaTek
export BUILD_HOSTNAME=MediaTek
export SELINUX_IGNORE_NEVERALLOWS=true
export BUILD_BROKEN_DUP_RULES=true
export ALLOW_MISSING_DEPENDENCIES=true
export RELAX_USES_LIBRARY_CHECK=true
export TZ=Asia/Dhaka #put before last build command
blissify -v begonia

# upload rom (if you don't need to upload multiple files, then you don't need to edit next line)
rclone copy out/target/product/$(grep unch $CIRRUS_WORKING_DIR/build_rom.sh -m 1 | cut -d ' ' -f 2 | cut -d _ -f 2 | cut -d - -f 1)/*.zip cirrus:$(grep unch $CIRRUS_WORKING_DIR/build_rom.sh -m 1 | cut -d ' ' -f 2 | cut -d _ -f 2 | cut -d - -f 1) -P
