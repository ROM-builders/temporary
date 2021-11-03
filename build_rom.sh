# sync rom
repo init --depth=1 --no-repo-verify -u  git://github.com/Evolution-X/manifest -b elle -g default,-mips,-darwin,-notdefault
git clone https://github.com/fazrul1994/local_manifests.git --depth 1 .repo/local_manifests/evolution_manifest.xml
repo sync -c --no-clone-bundle --no-tags --optimized-fetch --prune --force-sync -j8

# build rom
. build/envsetup.sh
lunch evolution_poplar-userdebug
export TZ=Asia/Jakarta #put before last build command
mka evolution


# upload rom (if you don't need to upload multiple files, then you don't need to edit next line)
rclone copy out/target/product/$(grep unch $CIRRUS_WORKING_DIR/build_rom.sh -m 1 | cut -d ' ' -f 2 | cut -d _ -f 2 | cut -d - -f 1)/*.zip cirrus:$(grep unch $CIRRUS_WORKING_DIR/build_rom.sh -m 1 | cut -d ' ' -f 2 | cut -d _ -f 2 | cut -d - -f 1) -P
