# sync rom
repo init --depth=1 --no-repo-verify -u https://github.com/ArrowOS/android_manifest.git -b arrow-13.1  -g default,-mips,-darwin,-notdefault
git clone https://github.com/sounddrill31/local_manifests.git --depth 1 -b arrow-13.1-generic .repo/local_manifests
repo sync -c --no-clone-bundle --no-tags --optimized-fetch --prune --force-sync -j8

# build rom
source build/envsetup.sh
lunch arrow_gsi-userdebug
export TZ=Asia/Kolkata #put before last build command
mka systemimage

# upload rom (if you don't need to upload multiple files, then you don't need to edit next line)
mkdir out/target/product/gsi
cp out/target/product/*/system.img . 
zip out/target/product/gsi/ArrowOS-arrow-13.1-$(date +%Y%m%d)-SoundDrillGSI.zip system.img  

rclone copy out/target/product/$(grep unch $CIRRUS_WORKING_DIR/build_rom.sh -m 1 | cut -d ' ' -f 2 | cut -d _ -f 2 | cut -d - -f 1)/*.zip cirrus:$(grep unch $CIRRUS_WORKING_DIR/build_rom.sh -m 1 | cut -d ' ' -f 2 | cut -d _ -f 2 | cut -d - -f 1) -P
