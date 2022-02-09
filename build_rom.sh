# sync rom
repo init --depth=1 --no-repo-verify -u git://github.com/lighthouse-os/manifest.git -b raft -g default,-mips,-darwin,-notdefault
git clone https://https://github.com/Yshmany/local_manifest.git --depth 1 .repo/local_manifests
repo sync -c -q --force-sync --optimized-fetch --no-tags --no-clone-bundle --prune

# build rom
source build/envsetup.sh
lunch lineage_channel-userdebug
export TZ=Asia/Dhaka #put before last build command
mka lighthouse

# upload rom (if you don't need to upload multiple files, then you don't need to edit next line)
rclone copy out/target/product/$(grep unch $CIRRUS_WORKING_DIR/build_rom.sh -m 1 | cut -d ' ' -f 2 | cut -d _ -f 2 | cut -d - -f 1)/*.zip cirrus:$(grep unch $CIRRUS_WORKING_DIR/build_rom.sh -m 1 | cut -d ' ' -f 2 | cut -d _ -f 2 | cut -d - -f 1) -P
