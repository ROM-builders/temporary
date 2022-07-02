# sync rom
repo init --depth=1 --no-repo-verify -u https://github.com/CipherOS/android_manifest.git -b twelve-L -g default,-mips,-darwin,-notdefault
repo sync -c --no-clone-bundle --no-tags --optimized-fetch --prune --force-sync -j8
rm -rf vendor/qcom/opensource/commonsys/system/bt
rm -rf vendor/qcom/opensource/commonsys/bluetooth_ex
rm -rf vendor/qcom/opensource/commonsys/packages/apps/Bluetooth
git clone https://github.com/ryuKizuha/local_manifests.git --depth 1 -b master .repo/local_manifests

# build rom
. build/envsetup.sh
lunch cipher_begonia-userdebug
export TZ=Asia/Jakarta
mka bacon

# upload rom (if you don't need to upload multiple files, then you don't need to edit next line)
rclone copy out/target/product/$(grep unch $CIRRUS_WORKING_DIR/build_rom.sh -m 1 | cut -d ' ' -f 2 | cut -d _ -f 2 | cut -d - -f 1)/*.zip cirrus:$(grep unch $CIRRUS_WORKING_DIR/build_rom.sh -m 1 | cut -d ' ' -f 2 | cut -d _ -f 2 | cut -d - -f 1) -P
