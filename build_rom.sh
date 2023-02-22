# sync rom
repo init --depth=1 --no-repo-verify -u https://github.com/AOSPA/manifest -b topaz -g default,-mips,-darwin,-notdefault
git clone https://github.com/mrxzzet/local_manifests --depth=1 -b lineage-kernel .repo/local_manifests
repo sync --no-clone-bundle --current-branch --no-tags -j8

# patches
git clone https://github.com/mrxzzet/mi-thorium_patches patches
cd patches/common/system/core
git apply 0001-liblp-Allow-to-flash-on-bigger-block-device.patch
cd ../../../
cd lineage-20.x/vendor/lineage
git apply 0001-Split-msm8937-from-UM_3_18_FAMILY-and-fix-it.patch
cd ../../../../

#vendor
rm -rf vendor/qcom/opensource/data-ipa-cfg-mgr
git clone https://github.com/mrxzzet/android_vendor_qcom_opensource_data-ipa-cfg-mgr -b arrow-13.0 vendor/qcom/opensource/data-ipa-cfg-mgr

# build rom
. build/envsetup.sh
lunch aospa_Mi439-userdebug
export TZ=Asia/Dhaka #put before last build command
mka bacon

# upload rom (if you don't need to upload multiple files, then you don't need to edit next line)
rclone copy out/target/product/$(grep unch $CIRRUS_WORKING_DIR/build_rom.sh -m 1 | cut -d ' ' -f 2 | cut -d _ -f 2 | cut -d - -f 1)/*.zip cirrus:$(grep unch $CIRRUS_WORKING_DIR/build_rom.sh -m 1 | cut -d ' ' -f 2 | cut -d _ -f 2 | cut -d - -f 1) -P
#end
