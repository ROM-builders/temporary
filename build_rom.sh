# sync rom
repo init --depth=1 --no-repo-verify -u https://github.com/AOSPA/manifest -b topaz -g default,-mips,-darwin,-notdefault 
git clone https://github.com/alecchangod/local_manifest.git --depth 1 -b aospa .repo/local_manifests
repo sync -c --no-clone-bundle --no-tags --optimized-fetch --prune --force-sync -j8
 
# build rom
source build/envsetup.sh
lunch aospa_monet-user
# export WITH_GAPPS=true
export TZ=Asia/Hong_Kong #put before last build command
./rom-build.sh monet -c -t user -v release
# 14
# upload rom (if you don't need to upload multiple files, then you don't need to edit next line)
rclone copy out/target/product/$(grep unch $CIRRUS_WORKING_DIR/build_rom.sh -m 1 | cut -d ' ' -f 2 | cut -d _ -f 2 | cut -d - -f 1)/*.zip cirrus:$(grep unch $CIRRUS_WORKING_DIR/build_rom.sh -m 1 | cut -d ' ' -f 2 | cut -d _ -f 2 | cut -d - -f 1) -P




















