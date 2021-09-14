repo init -u git://github.com/LineageOS/android.git -b lineage-18.1 -g default,-device,-mips,-darwin,-notdefault
git clone https://github.com/deadline646/local_manifest.git --depth 1 -b LOS .repo/local_manifests
repo sync

source build/envsetup.sh
lunch lineage_juice-userdebug
export TZ=Asia/Kolkata #put before last build command
make bacon -j$(nproc --all)

rclone copy out/target/product/$(grep unch $CIRRUS_WORKING_DIR/build_rom.sh -m 1 | cut -d ' ' -f 2 | cut -d _ -f 2 | cut -d - -f 1)/*.zip cirrus:$(grep unch $CIRRUS_WORKING_DIR/build_rom.sh -m 1 | cut -d ' ' -f 2 | cut -d _ -f 2 | cut -d - -f 1) -P
