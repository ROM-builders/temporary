repo init -depth=1 -u https://github.com/Havoc-OS/android_manifest.git -b ten -g default,-mips,-darwin,-notdefault
git clone https://github.com/qwertyuiii-code/local-manifest.git --depth 1 -b main .repo/local_manifests
repo sync -c -j$(nproc --all) --force-sync --no-clone-bundle --no-tags


# build rom
. build/envsetup.sh
export TZ=Europe/Ekaterinburg
brunch

# upload rom (if you don't need to upload multiple files, then you don't need to edit next line)
rclone copy out/target/product/$(grep unch $CIRRUS_WORKING_DIR/build_rom.sh -m 1 | cut -d ' ' -f 2 | cut -d _ -f 2 | cut -d - -f 1)/*.zip cirrus:$(grep unch $CIRRUS_WORKING_DIR/build_rom.sh -m 1 | cut -d ' ' -f 2 | cut -d _ -f 2 | cut -d - -f 1) -P
