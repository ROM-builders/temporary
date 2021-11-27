# sync rom
repo init --depth=1 --no-repo-verify -u git://github.com/elytraOS/manifest.git -b skylight -g default,-mips,-darwin,-notdefault
git clone https://github.com/exynos7870shrp/local_manifest -b pine-s .repo/local_manifests
repo sync -c --no-clone-bundle --no-tags --optimized-fetch --prune --force-sync -j8

# build rom
. build/envsetup.sh
lunch elytra_pine-userdebug
export ALLOW_MISSING_DEPENDENCES=true
export TZ=Asia/Mumbai #put before last build command
brunch pine

# upload rom (if you don't need to upload multiple files, then you don't need to edit next line)
rclone copy out/target/product/$(grep unch $CIRRUS_WORKING_DIR/build_rom.sh -m 1 | cut -d ' ' -f 2 | cut -d _ -f 2 | cut -d - -f 1)/*.zip cirrus:$(grep unch $CIRRUS_WORKING_DIR/build_rom.sh -m 1 | cut -d ' ' -f 2 | cut -d _ -f 2 | cut -d - -f 1) -P
