# sync rom
repo init --depth=1 -u https://github.com/Corvus-AOSP/android_manifest.git -b 13 -g default,-mips,-darwin,-notdefault
git clone https://github.com/rizalef77/local_manifests.git --depth 1 -b main .repo/local_manifests
repo sync -j$(nproc --all) --force-sync --no-tags --no-clone-bundle

# build rom
source build/envsetup.sh
lunch corvus_viva-userdebug
export TZ=Asia/Jakarta #put before last build command
make corvus

# upload rom (if you don't need to upload multiple files, then you don't need to edit next line)
rclone copy out/target/product/$(grep unch $CIRRUS_WORKING_DIR/build_rom.sh -m 1 | cut -d ' ' -f 2 | cut -d _ -f 2 | cut -d - -f 1)/*.zip cirrus:$(grep unch $CIRRUS_WORKING_DIR/build_rom.sh -m 1 | cut -d ' ' -f 2 | cut -d _ -f 2 | cut -d - -f 1) -P
