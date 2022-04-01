# sync rom
repo init --depth=1 -u https://github.com/lighthouse-os/manifest.git -b sailboat_L1;
git clone https://github.com/SKORPION29/local_manifest --depth 1 -b main
repo sync -c --force-sync --optimized-fetch --no-tags --no-clone-bundle --prune -j$(nproc --all);

# build rom
source build/envsetup.sh
lunch lighthouse_miatoll-userdebug
export TZ=Asia/Dhaka #put before last build command
make lighthouse

# upload rom (if you don't need to upload multiple files, then you don't need to edit next line)
rclone copy out/target/product/$(grep unch $CIRRUS_WORKING_DIR/build_rom.sh -m 1 | cut -d ' ' -f 2 | cut -d _ -f 2 | cut -d - -f 1)/*.zip cirrus:$(grep unch $CIRRUS_WORKING_DIR/build_rom.sh -m 1 | cut -d ' ' -f 2 | cut -d _ -f 2 | cut -d - -f 1) -P
