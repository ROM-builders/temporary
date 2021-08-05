# sync rom
repo init -u git://github.com/crdroidandroid/android.git -b 11.0
git clone https://github.com/iamthecloverly/local_manifest.git --depth 1 -b main .repo/local_manifests
repo sync 

# build rom
source build/envsetup.sh
export TZ=Asia/Dhaka #put before last build command
make bacon

# upload rom (if you don't need to upload multiple files, then you don't need to edit next line)
rclone copy out/target/product/$(grep unch $CIRRUS_WORKING_DIR/build_rom.sh -m 1 | cut -d ' ' -f 2 | cut -d _ -f 2 | cut -d - -f 1)/*.zip cirrus:$(grep unch $CIRRUS_WORKING_DIR/build_rom.sh -m 1 | cut -d ' ' -f 2 | cut -d _ -f 2 | cut -d - -f 1) -P
