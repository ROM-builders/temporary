# sync rom
repo init -u https://github.com/DerpFest-12/manifest.git -b 12.1 -g default,-device,-mips,-darwin,-notdefault
git clone https://github.com/Apitpr0/local_manifests.git --depth 1 -b master .repo/local_manifests/derp_mi8937.xml
repo sync -c --no-clone-bundle --no-tags --optimized-fetch --prune --force-sync -j8

# build rom
source build/envsetup.sh
lunch derp_device-debug
export TZ=Asia/Kuala_Lumpur #put before last build command
mka derp 

# upload rom (if you don't need to upload multiple files, then you don't need to edit next line)
rclone copy out/target/product/$(grep unch $CIRRUS_WORKING_DIR/build_rom.sh -m 1 | cut -d ' ' -f 2 | cut -d _ -f 2 | cut -d - -f 1)/*.zip cirrus:$(grep unch $CIRRUS_WORKING_DIR/build_rom.sh -m 1 | cut -d ' ' -f 2 | cut -d _ -f 2 | cut -d - -f 1) -P
