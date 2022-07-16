# sync rom
repo init --depth=1 --no-repo-verify -u git https://github.com/ProjectBlaze/manifest.git -b 12.1 -g default,-mips,-darwin,-notdefault
git clone https://github.com/dikiawan-9/Local-Manifests.git --depth 1 -b Build-CI .repo/local_manifests
repo sync -c --no-clone-bundle --no-tags --optimized-fetch --prune --force-sync -j8

# build rom
 . build/envsetup.sh
lunch blaze_lavender-userdebug
export TZ=Asia/Jakarta
export BUILD_USERNAME=dikiawan
export SELINUX_IGNORE_NEVERALLOWS=true
brunch lavender

# upload rom (if you don't need to upload multiple files, then you don't need to edit next line)
rclone copy out/target/product/$(grep unch $CIRRUS_WORKING_DIR/build_rom.sh -m 1 | cut -d ' ' -f 2 | cut -d _ -f 2 | cut -d - -f 1)/*.zip cirrus:$(grep unch $CIRRUS_WORKING_DIR/build_rom.sh -m 1 | cut -d ' ' -f 2 | cut -d _ -f 2 | cut -d - -f 1) -P
