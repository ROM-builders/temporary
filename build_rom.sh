# sync rom
repo init --depth=1 --no-repo-verify -u git://github.com/Project-LegionOS/manifest.git -b 11 -g default,-device,-mips,-darwin,-notdefault
git clone https://github.com/Badroel07/manifest.git --depth 1 -b master .repo/local_manifests
repo sync -c --no-clone-bundle --no-tags --optimized-fetch --prune --force-sync -j8

#build_rom
. build/envsetup.sh
lunch legion_olivewood-userdebug
export TZ=Asia/Dhaka #put before last build comm
make clean && make legion

# upload rom (if you don't need to upload multiple files, then you don't need to edit next line)
rclone copy out/target/product/$(grep unch $CIRRUS_WORKING_DIR/build_rom.sh -m 1 | cut -d ' ' -f 2 | cut -d _ -f 2 | cut -d - -f 1)/*.zip cirrus:$(grep unch $CIRRUS_WORKING_DIR/build_rom.sh -m 1 | cut -d ' ' -f 2 | cut -d _ -f 2 | cut -d - -f 1) -P
