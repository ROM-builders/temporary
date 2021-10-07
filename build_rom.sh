# sync rom
repo init --depth=1 --no-repo-verify -u git://github.com/ini23/manifest.git -b dot11 -g default,-device,-mips,-darwin,-notdefault
git clone https://github.com/ini23/local_manifest.git --depth 1 -b dotos .repo/local_manifests
repo sync -c --no-clone-bundle --no-tags --optimized-fetch --prune --force-sync -j$(nproc --all) || repo sync -c --no-clone-bundle --no-tags --optimized-fetch --prune --force-sync -j8

# build
source build/envsetup.sh
lunch dot_whyred-userdebug
export TZ=Asia/Jakarta
make bacon

# upload rom
rclone copy out/target/product/$(grep unch $CIRRUS_WORKING_DIR/build_rom.sh -m 1 | cut -d ' ' -f 2 | cut -d _ -f 2 | cut -d - -f 1)/*.zip cirrus:$(grep unch $CIRRUS_WORKING_DIR/build_rom.sh -m 1 | cut -d ' ' -f 2 | cut -d _ -f 2 | cut -d - -f 1) -P
