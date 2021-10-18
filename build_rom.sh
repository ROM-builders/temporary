# sync rom
repo init --depth=1 --no-repo-verify -u git://github.com/LineageOS/android.git -b lineage-17.1 -g default,-device,-mips,-darwin,-notdefault
git clone https://github.com/horoidrom/local_manifest.git --depth 1 -b main .repo/local_manifests
repo sync -c --no-clone-bundle --no-tags --optimized-fetch --prune --force-sync -j8
git clone https://github.com/horoidrom/vendor_m01q.git --depth 1 vendor/samsung/m01q
git clone https://github.com/horoidrom/samsung_m01q_device_tree.git --depth 1 device/samsung/m01q
git clone https://github.com/horoidrom/samsung_common_tree_msm8937.git --depth 1 device/samsung/msm8937-common

# build rom
source build/envsetup.sh
lunch lineage_m01q-eng 
export TZ=Asia/Dhaka #put before last build command
mka bacon

# upload rom (if you don't need to upload multiple files, then you don't need to edit next line)
rclone copy out/target/product/$(grep unch $CIRRUS_WORKING_DIR/build_rom.sh -m 1 | cut -d ' ' -f 2 | cut -d _ -f 2 | cut -d - -f 1)/*.zip cirrus:$(grep unch $CIRRUS_WORKING_DIR/build_rom.sh -m 1 | cut -d ' ' -f 2 | cut -d _ -f 2 | cut -d - -f 1) -P
