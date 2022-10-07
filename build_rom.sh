# sync rom
repo init -u https://github.com/PixelExperience/manifest -b thirteen
git clone https://github.com/furkancakmak34x/local_manifest.git 1 -b master .repo/local_manifests
repo sync -c -j8 --force-sync --no-clone-bundle --no-tags

# build rom
source build/envsetup.sh
lunch aosp_taimen-userdebug
export TZ=Europe/Istanbul
mka bacon -j8

# upload rom (if you don't need to upload multiple files, then you don't need to edit next line.)
rclone copy out/target/product/$(grep unch $CIRRUS_WORKING_DIR/build_rom.sh -m 1 | cut -d ' ' -f 2 | cut -d _ -f 2 | cut -d - -f 1)/*.zip cirrus:$(grep unch $CIRRUS_WORKING_DIR/build_rom.sh -m 1 | cut -d ' ' -f 2 | cut -d _ -f 2 | cut -d - -f 1) -P
