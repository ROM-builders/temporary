# sync rom
repo init --depth=1 --no-repo-verify -u repo init -u https://github.com/ArrowOS/android_manifest.git -b arrow-13.0 -g default,-mips,-darwin,-notdefault
git clone https://github.com/sajidshahriar72543/local_manifest.git --depth 1 -b arrow-whyred .repo/local_manifests
repo sync -c --no-clone-bundle --no-tags --optimized-fetch --prune --force-sync -j8

#13

# build rom
. build/envsetup.sh
lunch arrow_whyred-userdebug
export ARROW_GAPPS=true
export TZ=Asia/Dhaka
export KBUILD_BUILD_USER=PaperBoy
export BUILD_HOSTNAME=PaperBoy #put before last build command
m bacon

# upload rom (if you don't need to upload multiple files, then you don't need to edit next line)
rclone copy out/target/product/$(grep unch $CIRRUS_WORKING_DIR/build_rom.sh -m 1 | cut -d ' ' -f 2 | cut -d _ -f 2 | cut -d - -f 1)/*.zip cirrus:$(grep unch $CIRRUS_WORKING_DIR/build_rom.sh -m 1 | cut -d ' ' -f 2 | cut -d _ -f 2 | cut -d - -f 1) -P
