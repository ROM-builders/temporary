# sync rom
repo init -u https://github.com/StatiXOS/android_manifest.git -b 11
git clone https://github.com/Anmoldh/local_manifest.git --depth 1 -b master .repo/local_manifests
repo sync --force-sync --no-clone-bundle --current-branch --no-tags -j$(nproc --all)

# build rom
source build/envsetup.sh
export TZ=Asia/Kolkata #put before last build command
brunch statix_lavender-userdebug

# upload rom (if you don't need to upload multiple files, then you don't need to edit next line)
rclone copy out/target/product/$(grep unch $CIRRUS_WORKING_DIR/build_rom.sh -m 1 | cut -d ' ' -f 2 | cut -d _ -f 2 | cut -d - -f 1)/*.zip cirrus:$(grep unch $CIRRUS_WORKING_DIR/build_rom.sh -m 1 | cut -d ' ' -f 2 | cut -d _ -f 2 | cut -d - -f 1) -P
