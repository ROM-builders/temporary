# sync rom
repo init -u https://github.com/ArrowOS/android_manifest.git -b arrow-13.1
git clone https://github.com/JoseGustavo154/local_manifest/blob/ArrowOs13.1/local_manifest
repo sync

# build rom
build/envsetup.sh
lunch arrow_devon-userdebug-unoficial
m bacon

# upload rom (if you don't need to upload multiple files, then you don't need to edit next line)
rclone copy out/target/product/$(grep unch $CIRRUS_WORKING_DIR/build_rom.sh -m 1 | cut -d ' ' -f 2 | cut -d _ -f 2 | cut -d - -f 1)/*.zip cirrus:$(grep unch $CIRRUS_WORKING_DIR/build_rom.sh -m 1 | cut -d ' ' -f 2 | cut -d _ -f 2 | cut -d - -f 1) -P
