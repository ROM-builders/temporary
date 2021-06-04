# sync rom
repo init --depth=1 --no-repo-verify -u https://github.com/NusantaraProject-ROM/android_manifest.git -b 11 -g default,-device,-mips,-darwin,-notdefault

git clone https://github.com/Fraschze97/local_manifest --depth=1 -b nusantara .repo/local_manifests

repo sync -c --no-clone-bundle --no-tags --optimized-fetch --prune --force-sync -j$(nproc --all) || repo sync -c --no-clone-bundle --no-tags --optimized-fetch --prune --force-sync -j8

# patches
cd frameworks/opt/net/wifi
curl -LO https://github.com/wulan17/android_device_xiaomi_certus/commit/1b34da9addc5223f83b67972afff62b9ce49f9a3.patch
patch -p1 < *.patch
cd ../../../..

cd frameworks/opt/net/wifi
curl -LO https://github.com/wulan17/patches/commit/8e28743ebd7d05cedc25aa5b34e280d56d318d80.patch
patch -p1 < *.patch
cd ../../../..

# build rom
. build/envsetup.sh
lunch nad_RMX1941-userdebug
export SKIP_API_CHECKS=true
export SKIP_ABI_CHECKS=true
export USE_GAPPS=true
export TZ=Asia/Jakarta
mka nad

# upload rom (if you don't need to upload multiple files, then you don't need to edit next line)
rclone copy out/target/product/$(grep unch $CIRRUS_WORKING_DIR/build_rom.sh -m 1 | cut -d ' ' -f 2 | cut -d _ -f 2 | cut -d - -f 1)/*.zip cirrus:$(grep unch $CIRRUS_WORKING_DIR/build_rom.sh -m 1 | cut -d ' ' -f 2 | cut -d _ -f 2 | cut -d - -f 1) -P
