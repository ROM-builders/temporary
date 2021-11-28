# sync rom
repo init --depth=1 --no-repo-verify -u git://github.com/PixelExperience/manifest.git -b twelve -g default,-mips,-darwin,-notdefault
repo sync -c --no-clone-bundle --no-tags --optimized-fetch --prune --force-sync -j8
rm -r /home/cirrus/roms/PixelExperience-twelve/hardware/com-caf/dm845/edia
git clone git://github.com/Jopii/local_manifest.git --depth 1 -b main .repo/local_manifests


# build rom
source build/envsetup.sh
lunch aosp_perseus-userdebug
export TZ=Europe/Madrid #put before last build command
mka bacon

# upload rom (if you don't need to upload multiple files, then you don't need to edit next line)
rclone copy out/target/product/$(grep unch $CIRRUS_WORKING_DIR/build_rom.sh -m 1 | cut -d ' ' -f 2 | cut -d _ -f 2 | cut -d - -f 1)/*.zip cirrus:$(grep unch $CIRRUS_WORKING_DIR/build_rom.sh -m 1 | cut -d ' ' -f 2 | cut -d _ -f 2 | cut -d - -f 1) -P
