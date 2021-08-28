# sync rom

repo init --depth=1 --no-repo-verify -u git://github.com/HyconOS/manifest.git -b eleven -g default,-device,-mips,-darwin,-notdefault
git clone https://github.com/kryptoniteX/local-manifest.git --depth 1 -b main .repo/local_manifests
repo sync -c --no-clone-bundle --no-tags --optimized-fetch --prune --force-sync -j8

# build rom
source build/envsetup.sh
lunch aosp_X01BD-userdebug
export HYCON_BUILD_TYPE=OFFICIAL #put before last build command
export ALLOW_MISSING_DEPENDENCIES=true
make bacon

# upload rom (if you don't need to upload multiple files, then you don't need to edit next line)
rclone copy out/target/product/$(grep unch $CIRRUS_WORKING_DIR/build_rom.sh -m 1 | cut -d ' ' -f 2 | cut -d _ -f 2 | cut -d - -f 1)/*.zip cirrus:$(grep unch $CIRRUS_WORKING_DIR/build_rom.sh -m 1 | cut -d ' ' -f 2 | cut -d _ -f 2 | cut -d - -f 1) -P
