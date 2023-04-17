# sync rom
repo init --depth=1 --no-repo-verify -u https://github.com/Colt-Enigma/platform_manifest.git -b c13.1 -g default,-mips,-darwin,-notdefault
git clone https://github.com/andriirosemary/Local_Manifest.git --depth 1 -b rosemary-coltos-tiramisu .repo/local_manifests
repo sync -c --no-clone-bundle --no-tags --optimized-fetch --prune --force-sync -j8

# build rom
source build/envsetup.sh
export TZ=Asia/Dhaka #put before last build command
lunch colt_rosemary-userdebug
make colt

# upload rom (if you don't need to upload multiple files, then you don't need to edit next line)
rclone copy out/target/product/$(grep unch $CIRRUS_WORKING_DIR/build_rom.sh -m 1 | cut -d ' ' -f 2 | cut -d _ -f 2 | cut -d - -f 1)/*.zip cirrus:$(grep unch $CIRRUS_WORKING_DIR/build_rom.sh -m 1 | cut -d ' ' -f 2 | cut -d _ -f 2 | cut -d - -f 1) -P
