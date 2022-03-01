# sync rom
repo init --depth=1 -u https://github.com/crdroidandroid/android -b 11.0
git clone https://github.com/Krishdangi/local_manifests/ -b main .repo/local_manifests
repo sync --no-clone-bundle --force-sync

# build rom
source build/envsetup.sh
lunch lineage_rosemary-userdebug
export TZ=Asia/Dhaka #put before last build command
mka bacon

# upload rom (if you don't need to upload multiple files, then you don't need to edit next line)
rclone copy out/target/product/$(grep unch $CIRRUS_WORKING_DIR/build_rom.sh -m 1 | cut -d ' ' -f 2 | cut -d _ -f 2 | cut -d - -f 1)/*.zip cirrus:$(grep unch $CIRRUS_WORKING_DIR/build_rom.sh -m 1 | cut -d ' ' -f 2 | cut -d _ -f 2 | cut -d - -f 1) -P
