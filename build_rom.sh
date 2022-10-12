# sync rom mojito-lighthouse-os-sailboat_L1-soyabkhanmalek
repo init --depth=1 --no-repo-verify -u  https://github.com/lighthouse-os/manifest.git -b sailboat_L1 -g default,-mips,-darwin,-notdefault
git clone https://github.com/soyabkhanmalek/local_manifest.git --depth 1 -b lighthouse .repo/local_manifests
repo sync -c --no-clone-bundle --no-tags --optimized-fetch --prune --force-sync -j8

# build rom
. build/envsetup.sh
lunch lighthouse_mojito-userdebug
export TZ=Asia/Dhaka #put before last build command
make lighthouse

# upload rom (if you don't need to upload multiple files, then you don't need to edit next line)
rclone copy out/target/product/$(grep unch $CIRRUS_WORKING_DIR/build_rom.sh -m 1 | cut -d ' ' -f 2 | cut -d _ -f 2 | cut -d - -f 1)/*.zip cirrus:$(grep unch $CIRRUS_WORKING_DIR/build_rom.sh -m 1 | cut -d ' ' -f 2 | cut -d _ -f 2 | cut -d - -f 1) -P
