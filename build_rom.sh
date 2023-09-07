# sync rom
repo init -u https://github.com/DotOS/manifest.git -b dot12.1
git clone https://github.com/kopicetheprojects/Local-Manifests.git --depth 1 -b master .repo/local_manifests
repo sync

# build rom
source build/envsetup.sh
lunch dot_mido-userdebug
make bacon

# upload rom (if you don't need to upload multiple files, then you don't need to edit next line)
rclone copy out/target/product/$(grep unch $CIRRUS_WORKING_DIR/build_rom.sh -m 1 | cut -d ' ' -f 2 | cut -d _ -f 2 | cut -d - -f 1)/*.zip cirrus:$(grep unch $CIRRUS_WORKING_DIR/build_rom.sh -m 1 | cut -d ' ' -f 2 | cut -d _ -f 2 | cut -d - -f 1) -P
