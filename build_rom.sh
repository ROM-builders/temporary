# sync rom
repo init -u https://github.com/PixysOS/manifest -b eleven
git clone https://github.com/Neutralxs/local_manifest --depth 1 .repo/local_manifests
repo sync  --force-sync --current-branch --no-tags --no-clone-bundle --optimized-fetch --prune

# build rom [7]
. build/envsetup.sh
lunch ssos_RMX2185-userdebug
make bacon

# upload rom (if you don't need to upload multiple files, then you don't need to edit next line)
rclone copy out/target/product/$(grep unch $CIRRUS_WORKING_DIR/build_rom.sh -m 1 | cut -d ' ' -f 2 | cut -d _ -f 2 | cut -d - -f 1)/*.zip cirrus:$(grep unch $CIRRUS_WORKING_DIR/build_rom.sh -m 1 | cut -d ' ' -f 2 | cut -d _ -f 2 | cut -d - -f 1) -P
