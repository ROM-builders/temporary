# sync rom
repo init -u https://github.com/Corvus-Q/android_manifest.git -b 10 -g default,-device,-mips,-darwin,-notdefault
git clone https://github.com/atharv2951/local_manifest --depth 1 -b main .repo/local_manifests
repo sync -j$(nproc --all) --force-sync --no-tags --no-clone-bundle

# build rom
. build/envsetup.sh
lunch du_j7veltw-userdebug
export TZ=Asia/Dhaka #put before last build command
make corvus

# upload rom (if you don't need to upload multiple files, then you don't need to edit next line)
rclone copy out/target/product/$(grep unch $CIRRUS_WORKING_DIR/build_rom.sh -m 1 | cut -d ' ' -f 2 | cut -d _ -f 2 | cut -d - -f 1)/*.zip cirrus:$(grep unch $CIRRUS_WORKING_DIR/build_rom.sh -m 1 | cut -d ' ' -f 2 | cut -d _ -f 2 | cut -d - -f 1) -P
