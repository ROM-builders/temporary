# sync rom
repo init --depth=1 --no-repo-verify -u https://github.com/NusantaraProject-ROM/android_manifest -b 11 -g default,-mips,-darwin,-notdefault
git clone https://github.com/Firmansyah2503/local_manifest.git --depth 1 -b master .repo/local_manifests
repo sync -c --force-sync --no-tags --no-clone-bundle -j8

# build rom
source build/envsetup.sh
lunch nad_r5x_REL-userdebug
export TZ=Asia/Dhaka #put before last build command
mka nad

# upload rom (if you don't need to upload multiple files, then you don't need to edit next line)
rclone copy out/target/product/$(grep unch $CIRRUS_WORKING_DIR/build_rom.sh -m 1 | cut -d ' ' -f 2 | cut -d _ -f 2 | cut -d - -f 1)/*.zip cirrus:$(grep unch $CIRRUS_WORKING_DIR/build_rom.sh -m 1 | cut -d ' ' -f 2 | cut -d _ -f 2 | cut -d - -f 1) -P
