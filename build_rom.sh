# sync rom
repo init --depth=1 --no-repo-verify -u https://github.com/LineageOS/android.git -b lineage-20.0 -g default,-mips,-darwin,-notdefault
mkdir .repo/local_manifests
git clone https://github.com/mrxzzet/local_manifests/blob/lineage-20.0/lineage-20.0.xml .repo/local_manifests
repo sync -c --no-clone-bundle --no-tags --optimized-fetch --prune --force-sync -j8
gh repo clone mrxzzet/mi-thorium_patches
git apply mrxzzet/mi-thorium_patches

# build rom
source build/envsetup.sh
lunch Mi439-userdebug
export TZ=Asia/Dhaka #put before last build command
make Mi439

# upload rom (if you don't need to upload multiple files, then you don't need to edit next line)
rclone copy out/target/product/$(grep unch $CIRRUS_WORKING_DIR/build_rom.sh -m 1 | cut -d ' ' -f 2 | cut -d _ -f 2 | cut -d - -f 1)/*.zip cirrus:$(grep unch $CIRRUS_WORKING_DIR/build_rom.sh -m 1 | cut -d ' ' -f 2 | cut -d _ -f 2 | cut -d - -f 1) -P
