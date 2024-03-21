# sync rom
repo init -u https://github.com/CipherOS/android_manifest.git -b thirteen
git clone https://github.com/blueseaxy/local_manifests -b aosp-fog .repo/local_manifests
repo sync -c --force-sync --optimized

# build rom
. build/envsetup.sh
lunch cipher_(fog)-userdebug
export TZ=Asia/Dhaka #put before last build command
mka bacon

# upload rom (if you don't need to upload multiple files, then you don't need to edit next line)
rclone copy out/target/product/$(grep unch $CIRRUS_WORKING_DIR/build_rom.sh -m 1 | cut -d ' ' -f 2 | cut -d _ -f 2 | cut -d - -f 1)/*.zip cirrus:$(grep unch $CIRRUS_WORKING_DIR/build_rom.sh -m 1 | cut -d ' ' -f 2 | cut -d _ -f 2 | cut -d - -f 1) -P
