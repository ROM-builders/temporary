# sync rom
repo init --depth=1 --no-repo-verify -u https://github.com/LineageOS/android -b lineage-17.1 -g default,-device,-mips,-darwin,-notdefault
#git clone https://github.com/pocox3pro/Local-Manifests.git --depth 1 -b master .repo/local_manifests
repo sync -c --no-clone-bundle --no-tags --optimized-fetch --prune --force-sync -j8

git clone https://github.com/TheMuppets/proprietary_vendor_google -b lineage-17.1 vendor/google --depth=1

# build rom
source build/envsetup.sh
lunch lineage_sargo-userdebug || echo
lunch lineage_sargo-userdebug
export TZ=Asia/Dhaka #put before last build command
m bacon

# upload rom (if you don't need to upload multiple files, then you don't need to edit next line)
rclone copy out/target/product/$(grep unch $CIRRUS_WORKING_DIR/build_rom.sh -m 1 | cut -d ' ' -f 2 | cut -d _ -f 2 | cut -d - -f 1)/*.zip cirrus:$(grep unch $CIRRUS_WORKING_DIR/build_rom.sh -m 1 | cut -d ' ' -f 2 | cut -d _ -f 2 | cut -d - -f 1) -P
