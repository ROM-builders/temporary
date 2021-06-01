# sync rom
repo init --depth=1 --no-repo-verify -u git://github.com/AOSPA/manifest -b ruby -g default,-device,-mips,-darwin,-notdefault
git clone https://github.com/derp-sdm660-common/Local-Manifests.git --depth 1 -b aospa .repo/local_manifests
repo sync -c --no-clone-bundle --no-tags --optimized-fetch --prune --force-sync -j8 || repo sync -c --no-clone-bundle --no-tags --optimized-fetch --prune --force-sync -j8

#patches
cd device/qcom/common && curl -L -o mypatch.patch https://github.com/AOSPA/android_device_qcom_common/commit/b42838e08f2e21cc1ce78961a8bca3a7e40d914e.patch && patch -p1 < mypatch.patch && cd -
cd vendor/pa && curl -L -o mypatch.patch https://github.com/AOSPA/android_vendor_pa/commit/ec27f18b4a374f7041e1693058e205e0fcfbe734.patch && patch -p1 < mypatch.patch && cd -
cd vendor/pa && curl -L -o mypatch.patch https://github.com/AOSPA/android_vendor_pa/commit/f0bfe716960ee8498d6a9442d734615909163d6b.patch && patch -p1 < mypatch.patch && cd -
cd device/qcom/kernelscripts && curl -L -o mypatch.patch https://github.com/AOSPA/android_kernel_build/commit/0dfbc9cdf2f6ca505604859ec275ba4a0b81f038.patch && patch -p1 < mypatch.patch && cd -

# build rom
#build/envsetup.sh
#lunch aosp_X00TD-user
./rom-build.sh X00TD -t user

# upload rom (if you don't need to upload multiple files, then you don't need to edit next line)
rclone copy out/target/product/$(grep unch $CIRRUS_WORKING_DIR/build_rom.sh -m 1 | cut -d ' ' -f 2 | cut -d _ -f 2 | cut -d - -f 1)/*.zip cirrus:$(grep unch $CIRRUS_WORKING_DIR/build_rom.sh -m 1 | cut -d ' ' -f 2 | cut -d _ -f 2 | cut -d - -f 1) -P
