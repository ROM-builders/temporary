# Sync Rom Manifest
repo init https://github.com/CherishOS/android_manifest.git -b tiramisu
# Sync Manifest
git clone https://github.com/YudhoPatrianto/local_manifests -b beta .repo/local_manifests

#Sync ROM
repo sync -c --force-sync --no-clone-bundle -j$(nproc --all)

# build rom
build/envsetup.sh
lunch cherish_selene-userdebug
export TARGET_USES_BLUR=false
export TARGET_USE_BLUR=false
export EXTRA_UDFPS_ANIMATIONS=true
export SELINUX_INGNORE_NEVERALLOWS=true
mka bacon

# upload rom (if you don't need to upload multiple files, then you don't need to edit next line)
rclone copy out/target/product/$(grep unch $CIRRUS_WORKING_DIR/build_rom.sh -m 1 | cut -d ' ' -f 2 | cut -d _ -f 2 | cut -d - -f 1)/*.zip cirrus:$(grep unch $CIRRUS_WORKING_DIR/build_rom.sh -m 1 | cut -d ' ' -f 2 | cut -d _ -f 2 | cut -d - -f 1) -P
