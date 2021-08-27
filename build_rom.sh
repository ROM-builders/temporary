# sync rom
repo init --depth=1 --no-repo-verify -u git://github.com/Colt-Enigma/platform_manifest.git -b c11 -g default,-device,-mips,-darwin,-notdefault
git clone https://github.com/rockstar5495/local_manifest.git --depth 1 -b main .repo/local_manifests
repo sync --no-tags --no-clone-bundle --force-sync -c -j8

# build rom
source . build/envsetup.sh
lunch colt_mido-userdebug
export TZ=Asia/Dhaka #put before last build command
mka colt-j8

# upload rom (if you don't need to upload multiple files, then you don't need to edit next line)
rclone copy out/target/product/$(grep unch $CIRRUS_WORKING_DIR/build_rom.sh -m 1 | cut -d ' ' -f 2 | cut -d _ -f 2 | cut -d - -f 1)/*.zip cirrus:$(grep unch $CIRRUS_WORKING_DIR/build_rom.sh -m 1 | cut -d ' ' -f 2 | cut -d _ -f 2 | cut -d - -f 1) -P
