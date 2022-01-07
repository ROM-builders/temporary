# sync rom
repo init -u https://github.com/CherishOS/android_manifest.git -b twelve
repo sync -c --no-clone-bundle --no-tags --optimized-fetch --prune --force-sync -j8
git clone https://gitlab.com/marat2509/cherishos_lava.git -b a12
mv ./cherishos_lava/* . -f


# build rom
lunch cherish_lava-user
export SELINUX_IGNORE_NEVERALLOWS_ON_USER=true
mka bacon

# upload rom (if you don't need to upload multiple files, then you don't need to edit next line)
rclone copy out/target/product/$(grep unch $CIRRUS_WORKING_DIR/build_rom.sh -m 1 | cut -d ' ' -f 2 | cut -d _ -f 2 | cut -d - -f 1)/*.zip cirrus:$(grep unch $CIRRUS_WORKING_DIR/build_rom.sh -m 1 | cut -d ' ' -f 2 | cut -d _ -f 2 | cut -d - -f 1) -P
