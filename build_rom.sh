# sync rom
repo init --depth=1 --no-repo-verify -u git://github.com/Komodo-OS/manifest -b 12.2 -g default,-mips,-darwin,-notdefault
git clone https://github.com/Hemker1469-whyred/local_manifest --depth 1 -b komodo-12.2 .repo/local_manifest
repo sync -c --no-clone-bundle --no-tags

# build rom
source build/envsetup.sh
lunch komodo_vayu-userdebug
export TZ=Asia/Dhaka #put before last build command
mka komod

# upload rom (if you don't need to upload multiple files, then you don't need to edit next line)
rclone copy out/target/product/$(grep unch $CIRRUS_WORKING_DIR/build_rom.sh -m 1 | cut -d ' ' -f 2 | cut -d _ -f 2 | cut -d - -f 1)/*.zip cirrus:$(grep unch $CIRRUS_WORKING_DIR/build_rom.sh -m 1 | cut -d ' ' -f 2 | cut -d _ -f 2 | cut -d - -f 1) -P
