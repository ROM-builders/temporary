# Create a directory for the source files
# This can be located anywhere (as long as the fs is case-sensitive)
$ mkdir crDroid
$ cd crDroid

# Install Repo in the created directory
$ repo init -u https://github.com/crdroidandroid/android.git -b 12.1
git clone https://github.com/dikiawan-9/Local-Manifest.git --depth 1 -b Build .repo/local_manifests
repo sync -c --no-clone-bundle --no-tags --optimized-fetch --prune --force-sync -j8

# build rom
# Run to prepare our devices list
$ . build/envsetup.sh
# ... now run
$ brunch lavender_userdebug

# upload rom (if you don't need to upload multiple files, then you don't need to edit next line)
rclone copy out/target/product/$(grep unch $CIRRUS_WORKING_DIR/build_rom.sh -m 1 | cut -d ' ' -f 2 | cut -d _ -f 2 | cut -d - -f 1)/*.zip cirrus:$(grep unch $CIRRUS_WORKING_DIR/build_rom.sh -m 1 | cut -d ' ' -f 2 | cut -d _ -f 2 | cut -d - -f 1) -P
