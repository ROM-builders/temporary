# sync rom
repo init --depth=1 --no-repo-verify -u git://github.com/PixelExperience/manifest.git -b 11 -g default,-mips,-darwin,-notdefault
#git clone https://github.com/pocox3pro/Local-Manifests.git --depth 1 -b master .repo/local_manifests
repo sync -c --no-clone-bundle --no-tags --optimized-fetch --prune --force-sync -j16

git clone https://github.com/Sushrut1101-ROMs/device_xiaomi_garden.git device/xiaomi/garden
git clone https://github.com/Sushrut1101-ROMs/vendor_xiaomi_garden.git vendor/xiaomi/garden
git clone https://github.com/kbt69/android_external_libaptX.git external/libaptx

# build rom
source build/envsetup.sh
lunch derp_vayu-user
export TZ=Asia/Kolkata #put before last build command
mka derp

# upload rom (if you don't need to upload multiple files, then you don't need to edit next line)
#rclone copy out/target/product/$(grep unch $CIRRUS_WORKING_DIR/build_rom.sh -m 1 | cut -d ' ' -f 2 | cut -d _ -f 2 | cut -d - -f 1)/*.zip cirrus:$(grep unch $CIRRUS_WORKING_DIR/build_rom.sh -m 1 | cut -d ' ' -f 2 | cut -d _ -f 2 | cut -d - -f 1) -P

transfer wet 
