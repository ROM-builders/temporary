# sync rom
repo init -u https://github.com/PixelExtended/manifest -b snow --depth=1 -g default,-mips,-darwin,-notdefault
git clone https://github.com/Ritvik6969/local_manifest.git --depth 1 -b Pixel-Extended .repo/local_manifests
repo sync -c --force-sync --optimized-fetch --no-tags --no-clone-bundle 

# build rom
. build/envsetup.sh
lunch aosp_vince-userdebug
export SELINUX_IGNORE_NEVERALLOWS=true
export TZ=Asia/Kolkata #put before last build command
mka bacon

# upload rom (if you don't need to upload multiple files, then you don't need to edit next line)
rclone copy out/target/product/$(grep unch $CIRRUS_WORKING_DIR/build_rom.sh -m 1 | cut -d ' ' -f 2 | cut -d _ -f 2 | cut -d - -f 1)/*.zip cirrus:$(grep unch $CIRRUS_WORKING_DIR/build_rom.sh -m 1 | cut -d ' ' -f 2 | cut -d _ -f 2 | cut -d - -f 1) -P
