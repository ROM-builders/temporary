# sync rom
repo init -u https://github.com/PixelOS-Pixelish/manifest -b eleven-plus --depth=1 --no-repo-verify -g default,-device,-mips,-darwin,-notdefault
git clone https://github.com/Dannoob/local_manifests.git --depth 1 -b master .repo/local_manifests
repo sync -c --no-clone-bundle --no-tags --optimized-fetch --prune --force-sync -j8

cd frameworks/base
git fetch https://github.com/Not-So-Pixel/frameworks_base
git cherry-pick 88c3e5eff52f3a5f6d262c724706d1111b1cf163
git cherry-pick bae72d655a479f0aa2d989e284229e5ecbffa022
git cherry-pick f0c63fc488090500fb2eea52c7f7b0de46c24cf7
cd ../..

# build rom
source build/envsetup.sh
lunch aosp_mi8937-user
export TZ=Asia/Dhaka #put before last build command
mka bacon

# upload rom (if you don't need to upload multiple files, then you don't need to edit next line)
rclone copy out/target/product/$(grep unch $CIRRUS_WORKING_DIR/build_rom.sh -m 1 | cut -d ' ' -f 2 | cut -d _ -f 2 | cut -d - -f 1)/*.zip cirrus:$(grep unch $CIRRUS_WORKING_DIR/build_rom.sh -m 1 | cut -d ' ' -f 2 | cut -d _ -f 2 | cut -d - -f 1) -P
