# sync rom
repo init --depth=1 --no-repo-verify -u git://github.com/PixelExperience/manifest -b twelve-plus -g default,-mips,-darwin,-notdefault
git clone https://github.com/thousandecibles/local_manifest.git --depth 1 -b main .repo/local_manifests
repo sync -c -$(nproc --all) --force-sync --no-clone-bundle --no-tags

# build rom
source build/envsetup.sh
lunch aosp_$device-userdebug
export TZ=Asia/kolkata #put before last build command
mka bacon -jX

# upload rom (if you don't need to upload multiple files, then you don't need to edit next line)
rclone copy out/target/product/$(grep unch $CIRRUS_WORKING_DIR/build_rom.sh -m 1 | cut -d ' ' -f 2 | cut -d _ -f 2 | cut -d - -f 1)/*.zip cirrus:$(grep unch $CIRRUS_WORKING_DIR/build_rom.sh -m 1 | cut -d ' ' -f 2 | cut -d _ -f 2 | cut -d - -f 1) -P
 
