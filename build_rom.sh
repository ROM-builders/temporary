# sync rom
repo init -u https://github.com/BlissRoms/platform_manifest.git -b arcadia
git clone https://github.com/SKORPION29/local_manifest --depth 1 -b main
repo sync -c --force-sync --no-tags --no-clone-bundle -j$(nproc --all) --optimized-fetch --prune

# build rom
source build/envsetup.sh
export TZ=Asia/Dhaka  #put before last build command
blissify bliss_miatoll-userdebug

# upload rom (if you don't need to upload multiple files, then you don't need to edit next line)
rclone copy out/target/product/$(grep unch $CIRRUS_WORKING_DIR/build_rom.sh -m 1 | cut -d ' ' -f 2 | cut -d _ -f 2 | cut -d - -f 1)/*.zip cirrus:$(grep unch $CIRRUS_WORKING_DIR/build_rom.sh -m 1 | cut -d ' ' -f 2 | cut -d _ -f 2 | cut -d - -f 1) -P
