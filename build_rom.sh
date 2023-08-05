# sync rom
repo init -u https://github.com/syberia-project/manifest.git -b 13.0
git clone https://github.com/rabikishan000/local_manifest.git --depth 1 -b main .repo/local_manifests
repo sync -c --force-sync --no-tags --no-clone-bundle -j$(nproc --all) --optimized-fetch --prune


# build rom
. build/envsetup.sh
lunch syberia_fleur-userdebug 
mka syberia
rm -rf platform/system/sepolicy/vendor/hal_light_default.te
rm -rf platform/system/sepolicy/vendor/rild.te
rm -rf system/sepolicy/vendor/hal_light_default.te
rm -rf system/sepolicy/vendor/rild.te

# upload rom (if you don't need to upload multiple files, then you don't need to edit next line)
rclone copy out/target/product/$(grep unch $CIRRUS_WORKING_DIR/build_rom.sh -m 1 | cut -d ' ' -f 2 | cut -d _ -f 2 | cut -d - -f 1)/*.zip cirrus:$(grep unch $CIRRUS_WORKING_DIR/build_rom.sh -m 1 | cut -d ' ' -f 2 | cut -d _ -f 2 | cut -d - -f 1) -P
