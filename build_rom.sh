# sync sources
repo init --depth=1 --no-repo-verify -u https://github.com/RiceDroid/android -b twelve -g default,-mips,-darwin,-notdefault
git clone https://github.com/UdayBindal2312/ROM_Manifest -b rice --depth 1 .repo/local_manifests
repo sync -c --no-clone-bundle --no-tags --optimized-fetch --prune --force-sync -j8

# Build rom
source build/envsetup.sh
lunch miatoll_lineage-userdebug
export TZ=Asia/Kolkata #Add before last build command
mka bacon

# Upload Rom
rclone copy out/target/product/$(grep unch $CIRRUS_WORKING_DIR/build_rom.sh -m 1 | cut -d ' ' -f 2 | cut -d _ -f 2 | cut -d - -f 1)/*.zip cirrus:$(grep unch $CIRRUS_WORKING_DIR/build_rom.sh -m 1 | cut -d ' ' -f 2 | cut -d _ -f 2 | cut -d - -f 1) -P
