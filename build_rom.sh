# sync rom
repo init --depth=1 -u https://github.com/DroidX-UI/manifest.git -b 13 -g default,-mips,-darwin,-notdefault
git clone https://github.com/Notganesh/local-Manifest.git --depth 1 -b main .repo/local_manifests
repo sync -c --no-clone-bundle --no-tags --optimized-fetch --prune --force-sync -j8
rm -rf system/libhidl
git clone https://github.com/ArrowOS/android_system_libhidl.git -b arrow-13.0 system/libhidl

# build rom
source build/envsetup.sh
lunch droidx_lime-eng
export TZ=Asia/Dhaka #put before last build command
m bacon

# upload rom (if you don't need to upload multiple files, then you don't need to edit next line)
rclone copy out/target/product/$(grep unch $CIRRUS_WORKING_DIR/build_rom.sh -m 1 | cut -d ' ' -f 2 | cut -d _ -f 2 | cut -d - -f 1)/*.zip cirrus:$(grep unch $CIRRUS_WORKING_DIR/build_rom.sh -m 1 | cut -d ' ' -f 2 | cut -d _ -f 2 | cut -d - -f 1) -P
