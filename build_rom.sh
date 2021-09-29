# sync rom
repo init -u git.github.com/ArrowOS/android_manifest.git -b arrow-10.0 -g default,-device,-mips,-darwin,-notdefault
git clone https://github.com/atharv2951/local_manifest --depth 1 -b main .repo/local_manifests
repo sync --force-sync --no-clone-bundle -j$(nproc --all)

# build rom
. build/envsetup.sh
brunch arrow_j7velte
export TZ=Asia/Dhaka #put before last build command
m bacon

# upload rom (if you don't need to upload multiple files, then you don't need to edit next line)
rclone copy out/target/product/$(grep unch $CIRRUS_WORKING_DIR/build_rom.sh -m 1 | cut -d ' ' -f 2 | cut -d _ -f 2 | cut -d - -f 1)/*.zip cirrus:$(grep unch $CIRRUS_WORKING_DIR/build_rom.sh -m 1 | cut -d ' ' -f 2 | cut -d _ -f 2 | cut -d - -f 1) -P
