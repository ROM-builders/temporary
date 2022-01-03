# sync rom
repo init --depth=1 --no-repo-verify -u https://github.com/CherishOS/android_manifest.git -b twelve -g default,-mips,-darwin,-notdefault
mv .repo/local_manifests /tmp/
git clone https://github.com/sndaire/local_manifest.git --depth 1 -b master .repo/local_manifests
repo sync -c --no-clone-bundle --no-tags --optimized-fetch --prune --force-sync -j8

# build rom
source build/envsetup.sh
ls device/xiaomi/miatoll
lunch cherish_miatoll-userdebug
export TZ=Africa/Nairobi #put before last build command
mka cherish

# upload rom (if you don't need to upload multiple files, then you don't need to edit next line)
rclone copy out/target/product/$(grep unch $CIRRUS_WORKING_DIR/build_rom.sh -m 1 | cut -d ' ' -f 2 | cut -d _ -f 2 | cut -d - -f 1)/*.zip cirrus:$(grep unch $CIRRUS_WORKING_DIR/build_rom.sh -m 1 | cut -d ' ' -f 2 | cut -d _ -f 2 | cut -d - -f 1) -P
