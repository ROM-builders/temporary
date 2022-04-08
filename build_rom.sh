# sync rom
repo init --depth=1 --no-repo-verify -u https://github.com/CherishOS/android_manifest.git -b twelve-one -g default,-mips,-darwin,-notdefault
git clone https://github.com/monu70152/local_manifest1.git --depth 1 -b cherish .repo/local_manifests
repo sync -c --no-clone-bundle --no-tags --optimized-fetch --prune --force-sync -j8

#14
# build rom 
. build/envsetup.sh
lunch cherish_X00TD-userdebug
export SELINUX_IGNORE_NEVERALLOWS=true
export TZ=Asia/Kolkata #put before last build commad
mka bacon

# upload rom (if you don't need to upload multiple files, then you don't need to edit next line)
rclone copy out/target/product/$(grep unch $CIRRUS_WORKING_DIR/build_rom.sh -m 1 | cut -d ' ' -f 2 | cut -d _ -f 2 | cut -d - -f 1)/*.zip cirrus:$(grep unch $CIRRUS_WORKING_DIR/build_rom.sh -m 1 | cut -d ' ' -f 2 | cut -d _ -f 2 | cut -d - -f 1) -P
