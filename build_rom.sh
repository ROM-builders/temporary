# sync rom
repo init -u https://github.com/ArrowOS/android_manifest.git -b arrow-13.1 
git clone https://github.com/angelomds42/local_manifest --depth 1 -b arrow .repo/local_manifests
repo sync --no-tags -c -j$(nproc --all) --force-sync --no-clone-bundle

# build rom
source build/envsetup.sh
lunch arrow_devon-userdebug
export TZ=Asia/Dhaka #put before last build comman
m otapackage

# upload rom (if you don't need to upload multiple files, then you don't need to edit next line)
rclone copy out/target/product/$(grep unch $CIRRUS_WORKING_DIR/build_rom.sh -m 1 | cut -d ' ' -f 2 | cut -d _ -f 2 | cut -d - -f 1)/*.zip cirrus:$(grep unch $CIRRUS_WORKING_DIR/build_rom.sh -m 1 | cut -d ' ' -f 2 | cut -d _ -f 2 | cut -d - -f 1) -P
