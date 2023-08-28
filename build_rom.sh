# sync rom
repo init --depth=1 --no-repo-verify -u repo init -u https://github.com/LineageOS/android.git -b lineage-18.1 --git-lfs -g default,-mips,-darwin,-notdefault
git clone https://github.com/Nobodyayushhere/local_manifest.git --depth 1 -b
# build rom
source build/envsetup.sh
lunch lineage_RMX1821-userdebug
export TZ=Asia/Dhaka #put before last build command
mka lineage

# upload rom (if you don't need to upload multiple files, then you don't need to edit next line)
rclone copy out/target/product/$(grep unch $CIRRUS_WORKING_DIR/build_rom.sh -m 1 | cut -d ' ' -f 2 | cut -d _ -f 2 | cut -d - -f 1)/*.zip cirrus:$(grep unch $CIRRUS_WORKING_DIR/build_rom.sh -m 1 | cut -d ' ' -f 2 | cut -d _ -f 2 | cut -d - -f 1) -P
