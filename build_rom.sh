# sync rom
repo init --depth=1 --no-repo-verify -u https://github.com/Fusion-OS/android_manifest -b twelve -g default,-mips,-darwin,-notdefault
git clone https://github.com/megumin775/Local-Manifests.git --depth 1 -b Fusion-OS .repo/local_manifests
repo sync -c --no-clone-bundle --no-tags --optimized-fetch --prune --force-sync -j8

# build 
. build/envsetup.sh
lunch fuse_X00TD-userdebug
export TZ=Asia/Jakarta
export BUILD_USER=hklknz
export BUILD_HOST=cloud
export BUILD_USERNAME=honoka
export SELINUX_IGNORE_NEVERALLOWS=true
export ALLOW_MISSING_DEPENDENCIES=true
export RELAX_USES_LIBRARY_CHECK=true
make fuse-prod

# upload rom (if you don't need to upload multiple files, then you don't need to edit next line)
rclone copy out/target/product/$(grep unch $CIRRUS_WORKING_DIR/build_rom.sh -m 1 | cut -d ' ' -f 2 | cut -d _ -f 2 | cut -d - -f 1)/*.zip cirrus:$(grep unch $CIRRUS_WORKING_DIR/build_rom.sh -m 1 | cut -d ' ' -f 2 | cut -d _ -f 2 | cut -d - -f 1) -P
