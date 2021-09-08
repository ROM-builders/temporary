#sync rom
repo init --depth=1 --no-repo-verify -u git://github.com/Project-Nova-UI/Manifest.git -b 11 -g default,-device,-mips,-darwin,-notdefault
git clone https://github.com/Jamesgosling2004/local_manifest.git --depth 1 -b master .repo/local_manifests
repo sync -c --no-clone-bundle --no-tags --optimized-fetch --prune --force-sync -j8

# build romm
source build/envsetup.sh
lunch lineage_RMX1831-userdebug
export TZ=Asia/Dhaka #put before last build command
brunch RMX1831

# upload rom (if you don't need to upload multiple files, then you don't need to edit next line)
rclone copy out/target/product/$(grep unch $CIRRUS_WORKING_DIR/build_rom.sh -m 1 | cut -d ' ' -f 2 | cut -d _ -f 2 | cut -d - -f 1)/*.zip cirrus:$(grep unch $CIRRUS_WORKING_DIR/build_rom.sh -m 1 | cut -d ' ' -f 2 | cut -d _ -f 2 | cut -d - -f 1) -P
