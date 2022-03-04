# sync rom
repo init -u https://github.com/baikalos/manifest.git -b q10.0 -g default,-mips,-darwin,-notdefault
git clone https://github.com/00p513-dev/local_manifests/raw/lineage-17.1/channel.xml --depth 1 .repo/local_manifests
repo sync

# build rom
source build/envsetup.sh
lunch lineage_channel-userdebug
export TZ=Asia/Dhaka #put before last build command
make

# upload rom (if you don't need to upload multiple files, then you don't need to edit next line)
rclone copy out/target/product/$(grep unch $CIRRUS_WORKING_DIR/build_rom.sh -m 1 | cut -d ' ' -f 2 | cut -d _ -f 2 | cut -d - -f 1)/*.zip cirrus:$(grep unch $CIRRUS_WORKING_DIR/build_rom.sh -m 1 | cut -d ' ' -f 2 | cut -d _ -f 2 | cut -d - -f 1) -P
