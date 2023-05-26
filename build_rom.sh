# sync rom
repo init -u https://github.com/ArrowOS/android_manifest.git -b arrow-13.1 -g default,-mips,-darwin,-notdefault
git clone https://github.com/xyz-sundram/local_manifest.git --depth 1 -b main  .repo/local_manifest
repo sync -c --no-clone-bundle --no-tags --optimized-fetch --prune --force-sync -j8

# build roms
. build/envsetup.sh
lunch arrow_tulip-userdebug
export ARROW_GAPPS=true
export SELINUX_IGNORE_NEVERALLOWS=true
export ALLOW_MISSING_DEPENDENCIES=true
export RELAX_USES_LIBRARY_CHECK=true
export TZ=Asia/Dhaka  #put before last command
m bacon

# upload rom (if you don't need to upload multiple files, then you don't need to edit next line)
rclone copy out/target/product/$(grep unch $CIRRUS_WORKING_DIR/build_rom.sh -m 1 | cut -d ' ' -f 2 | cut -d _ -f 2 | cut -d - -f 1)/*.zip cirrus:$(grep unch $CIRRUS_WORKING_DIR/build_rom.sh -m 1 | cut -d ' ' -f 2 | cut -d _ -f 2 | cut -d - -f 1) -P
