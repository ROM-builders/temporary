# sync rom
repo init --depth=1 --no-repo-verify -u https://github.com/syberia-project/manifest.git -b 11.0 -g default,-device,-mips,-darwin,-notdefault
git clone https://github.com/akira-vishal/fmanifest --depth 1 -b master .repo/local_manifests
repo sync -c --no-clone-bundle --no-tags --optimized-fetch --prune --force-sync -j8

# build rom
. build/envsetup.sh
lunch syberia_whyred-userdebug
export TZ=Asia/Dhaka #put before last build command
export USE_GAPPS=true
make syberia

# upload rom (if you don't need to upload multiple files, then you don't need to edit next line)
rclone copy out/target/product/$(grep unch $CIRRUS_WORKING_DIR/build_rom.sh -m 1 | cut -d ' ' -f 2 | cut -d _ -f 2 | cut -d - -f 1)/*.zip cirrus:$(grep unch $CIRRUS_WORKING_DIR/build_rom.sh -m 1 | cut -d ' ' -f 2 | cut -d _ -f 2 | cut -d - -f 1) -P
