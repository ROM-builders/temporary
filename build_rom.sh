# sync rom
repo init -u https://github.com/Octavi-Staging/manifest.git -b thirteen --depth=1
repo sync -c -f --force-sync --optimized-fetch --no-tags --no-clone-bundle --prune -j8

# build rom
source build/envsetup.sh
brunch octavi_spartan-userdebug

# upload rom (if you don't need to upload multiple files, then you don't need to edit next line)
rclone copy out/target/product/$(grep unch $CIRRUS_WORKING_DIR/build_rom.sh -m 1 | cut -d ' ' -f 2 | cut -d _ -f 2 | cut -d - -f 1)/*.zip cirrus:$(grep unch $CIRRUS_WORKING_DIR/build_rom.sh -m 1 | cut -d ' ' -f 2 | cut -d _ -f 2 | cut -d - -f 1) -P
