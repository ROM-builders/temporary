# sync rom
repo init git://github.com/Pranav-Talmale/twrp-a12-manifest.gitt -b main
git clone https://github.com/Pranav-Talmale/twrp-a12-local_manifest.git --depth 1 -b main .repo/local_manifests
repo sync 

# build rom
source build/envsetup.sh
lunch twrp_alioth-eng
mka adbd bootimage

# upload rom (if you don't need to upload multiple files, then you don't need to edit next line)
rclone copy out/target/product/$(grep unch $CIRRUS_WORKING_DIR/build_rom.sh -m 1 | cut -d ' ' -f 2 | cut -d _ -f 2 | cut -d - -f 1)/*.zip cirrus:$(grep unch $CIRRUS_WORKING_DIR/build_rom.sh -m 1 | cut -d ' ' -f 2 | cut -d _ -f 2 | cut -d - -f 1) -P
