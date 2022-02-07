# sync rom
repo init -u https://github.com/ResurrectionRemix/platform_manifest.git -b Q -g default,-mips,-darwin,-notdefault
git clone https://github.com/RayhanDz/Mzz-project -b main .repo/local_manifests
repo sync --force-sync --no-clone-bundle

# build rom
source build/envsetup.sh
lunch rr_$RMX1821-userdebug
export TZ=Asia/Jakarta #put before last build command
mka bacon

# upload rom (if you don't need to upload multiple files, then you don't need to edit next line)
rclone copy out/target/product/$(grep unch $CIRRUS_WORKING_DIR/build_rom.sh -m 1 | cut -d ' ' -f 2 | cut -d _ -f 2 | cut
