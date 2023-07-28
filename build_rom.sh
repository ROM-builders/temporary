# sync rom
repo init -u https://github.com/AOSPA/manifest -b topaz
git clone https://github.com/JoseGustavo154/local_manifest
repo sync --no-clone-bundle --current-branch --no-tags -j4

# build rom
source ./rom-build.sh 
aospa_devon-userdebug

# upload rom (if you don't need to upload multiple files, then you don't need to edit next line)
rclone copy out/target/product/$(grep unch $CIRRUS_WORKING_DIR/build_rom.sh -m 1 | cut -d ' ' -f 2 | cut -d _ -f 2 | cut -d - -f 1)/*.zip cirrus:$(grep unch $CIRRUS_WORKING_DIR/build_rom.sh -m 1 | cut -d ' ' -f 2 | cut -d _ -f 2 | cut -d - -f 1) -P
