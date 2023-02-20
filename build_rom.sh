# sync rom
repo init -u https://github.com/PixysOS/manifest -b thirteen
git clone https://github.com/mrxzzet/local_manifests-1 -b lineage-caf .repo/local_manifests
repo sync -c -j$(nproc --all) --force-sync --no-clone-bundle --no-tags

# applying patches
git clone https://github.com/Nem1xx/mi-thorium_patches patches
cd patches/common/system/core
git apply 0001-liblp-Allow-to-flash-on-bigger-block-device.patch
cd ../../../
cd patches/lineage-20.x/vendor/lineage
git apply 0001-Split-msm8937-from-UM_3_18_FAMILY-and-fix-it.patch
cd ../../../
rm -rf vendor/qcom/opensource/data-ipa-cfg-mgr
git clone https://github.com/janakniraula/android_vendor_qcom_opensource_data-ipa-cfg-mgr -b arrow-13.0 data-ipa-cfg-mgr

# build
. build/envsetup.sh
lunch pixys_Mi439-userdebug
export TZ=Asia/Dhaka #put before last build command
mka bacon

# upload rom (if you don't need to upload multiple files, then you don't need to edit next line)
rclone copy out/target/product/$(grep unch $CIRRUS_WORKING_DIR/build_rom.sh -m 1 | cut -d ' ' -f 2 | cut -d _ -f 2 | cut -d - -f 1)/*.zip cirrus:$(grep unch $CIRRUS_WORKING_DIR/build_rom.sh -m 1 | cut -d ' ' -f 2 | cut -d _ -f 2 | cut -d - -f 1) -P
