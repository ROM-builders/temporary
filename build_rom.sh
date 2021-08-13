# sync rom
repo init --depth=1 --no-repo-verify -u git://github.com/ProtonAOSP/android_manifest -b rvc -g default,-device,-mips,-darwin,-notdefault
git clone https://github.com/officialputuid/ProtonAOSP-RMX2001.git --depth 1 -b local_manifests .repo/local_manifests
repo sync -c --no-clone-bundle --no-tags --optimized-fetch --prune --force-sync -j8

# build rom
source build/envsetup.sh
lunch RMX2001-userdebug
export TZ=Asia/Makassar #put before last build command
make -j24 otapackage

# upload rom (if you don't need to upload multiple files, then you don't need to edit next line)
rclone copy out/target/product/$(grep unch $CIRRUS_WORKING_DIR/build_rom.sh -m 1 | cut -d ' ' -f 2 | cut -d _ -f 2 | cut -d - -f 1)/*.zip cirrus:$(grep unch $CIRRUS_WORKING_DIR/build_rom.sh -m 1 | cut -d ' ' -f 2 | cut -d _ -f 2 | cut -d - -f 1) -P
