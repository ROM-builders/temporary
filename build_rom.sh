# sync rom
repo init -u https://github.com/AOSPA/manifest -b sapphire -g default,-mips,-darwin,-notdefault 
git clone https://github.com/HimanishM25/local_manifest.git --depth 1 -b master .repo/local_manifest
repo sync -c --no-clone-bundle --no-tags --optimized-fetch --prune --force-sync -j8


# build rom
source build/envsetup.sh
lunch aospa_laurel_sprout
export TZ=Asia/India #put before last build command
./rom-build.sh laurel_sprout

# upload rom (if you don't need to upload multiple files, then you don't need to edit next line)
rclone copy out/target/product/$(grep unch $CIRRUS_WORKING_DIR/build_rom.sh -m 1 | cut -d ' ' -f 2 | cut -d _ -f 2 | cut -d - -f 1)/*.zip cirrus:$(grep unch $CIRRUS_WORKING_DIR/build_rom.sh -m 1 | cut -d ' ' -f 2 | cut -d _ -f 2 | cut -d - -f 1) -P
