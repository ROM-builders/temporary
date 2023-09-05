# sync rom
repo init --depth=1 --no-repo-verify -u repo init -u https://github.com/LineageOS/android.git -b lineage-20.0 --git-lfs -g default,-mips,-darwin,-notdefault
git clone https://github.com/neogen6/local_manifests.git --depth 1 -b lineage-20.0 .repo/local_manifests
repo sync -c --no-clone-bundle --no-tags --optimized-fetch --prune --force-sync -j8

# build rom
source build/envsetup.sh
lunch lineage_MiThoriumSSI-userdebug
export TZ=Asia/Kolkata #put before last build command
mka systemimage

# upload rom (if you don't need to upload multiple files, then you don't need to edit next line)
zip out/target/product/MiThoriumSSI/MiThoriumSSI-LineageOS.zip out/target/product/*/*.img
mv out/target/product/MiThoriumSSI/MiThoriumSSI-LineageOS.zip out/target/product/MiThoriumSSI/$(printf '%s_' $(grep -lZ 'MiThoriumSSI' out/target/product/*/*.img) | sed 's/_$/.zip/')
rclone copy out/target/product/$(grep unch $CIRRUS_WORKING_DIR/build_rom.sh -m 1 | cut -d ' ' -f 2 | cut -d _ -f 2 | cut -d - -f 1)/*.zip cirrus:$(grep unch $CIRRUS_WORKING_DIR/build_rom.sh -m 1 | cut -d ' ' -f 2 | cut -d _ -f 2 | cut -d - -f 1) -P
