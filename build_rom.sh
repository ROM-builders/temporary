# sync rom
repo init -u https://github.com/LineageOSMod/android.git -b lineage-18.1
git clone https://github.com/arnabpal2006/local_manifest/blob/main/local_manifest.xml
repo sync --current-branch --force-sync --no-clone-bundle --no-tags --prune

# build rom
source build/build_rom.sh
lunch derp_lavender-user
export TZ=Asia/Dhaka #put before last build command
mka derp

# upload rom (if you don't need to upload multiple files, then you don't need to edit next line)
rclone copy out/target/product/$(grep unch $CIRRUS_WORKING_DIR/build_rom.sh -m 1 | cut -d ' ' -f 2 | cut -d _ -f 2 | cut -d - -f 1)/*.zip cirrus:$(grep unch $CIRRUS_WORKING_DIR/build_rom.sh -m 1 | cut -d ' ' -f 2 | cut -d _ -f 2 | cut -d - -f 1) -P
