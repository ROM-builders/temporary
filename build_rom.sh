# sync rom
repo init --depth=1 --no-repo-verify -u https://github.com/LineageOS/android.git -b lineage-17.1 -g default,-mips,-darwin,-notdefault
mkdir .repo/local_manifests
git clone https://github.com/00p513-dev/local_manifests/raw/lineage-17.1/channel.xml > .repo/local_manifests/channel.xml
repo sync -c --no-clone-bundle --no-tags --optimized-fetch --prune --force-sync -j

# build rom
source build/envsetup.sh
lunch lineage_channel-user
export TZ=Asia/Dhaka #put before last build command
m bacon

# upload rom (if you don't need to upload multiple files, then you don't need to edit next line)
rclone copy out/target/product/$(grep unch $CIRRUS_WORKING_DIR/build_rom.sh -m 1 | cut -d ' ' -f 2 | cut -d _ -f 2 | cut -d - -f 1)/*.zip cirrus:$(grep unch $CIRRUS_WORKING_DIR/build_rom.sh -m 1 | cut -d ' ' -f 2 | cut -d _ -f 2 | cut -d - -f 1) -P
