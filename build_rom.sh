# sync rom
repo init --depth=1 --no-repo-verify -u git://github.com/CalyxOS/platform_manifest.git -b android10 -g default,-mips,-darwin,-notdefault
mkdir .repo/local_manifests
git clone https://raw.githubusercontent.com/Yshmany/Tree-Motorola/main/channel.txt --depth 1 -b main .repo/local_manifests
repo sync -c --no-clone-bundle --no-tags --optimized-fetch --prune --force-sync -j

# build rom
source build/envsetup.sh
lunch lineage_channel-userdebug
export TZ=Asia/Dhaka #put before last build command
make

# upload rom (if you don't need to upload multiple files, then you don't need to edit next line)
rclone copy out/target/product/$(grep unch $CIRRUS_WORKING_DIR/build_rom.sh -m 1 | cut -d ' ' -f 2 | cut -d _ -f 2 | cut -d - -f 1)/*.zip cirrus:$(grep unch $CIRRUS_WORKING_DIR/build_rom.sh -m 1 | cut -d ' ' -f 2 | cut -d _ -f 2 | cut -d - -f 1) -P
