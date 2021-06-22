# sync rom
repo init --depth=1 --no-repo-verify -u https://github.com/Corvus-R/android_manifest.git -b 11 -g default,-device,-mips,-darwin,-notdefault
git clone https://github.com/abhinavftp98/local_manifest.git --depth 1 -b los .repo/local_manifests
repo sync -c --no-clone-bundle --no-tags --optimized-fetch --prune --force-sync -j8

# build rom
source build/envsetup.sh
lunch corvus_RMX1805-userdebug
export TZ=Asia/Dhaka #put before last build command
make corvus

#patch
cd packages/apps/Settings && curl -O https://github.com/random-aosp-stuff/android_packages_apps_Settings/commit/32752dae1ea3d61a0f7603432bd9b662d062a1f0.patch && patch -p1 < *.patch && cd ../../..

cd frameworks/native && curl -O https://github.com/phhusson/platform_frameworks_native/commit/cc94e422c0a8b2680e7f9cfc391b2b03a56da765.patch && patch -p1 < *.patch && cd ../..

cd external/selinux && curl -O https://github.com/phhusson/platform_external_selinux/commit/38d614ec61d610459a7f8e3a243a3dab7a20d356.patch && patch -p1 < *.patch && cd ../..

# upload rom (if you don't need to upload multiple files, then you don't need to edit next line)
rclone copy out/target/product/$(grep unch $CIRRUS_WORKING_DIR/build_rom.sh -m 1 | cut -d ' ' -f 2 | cut -d _ -f 2 | cut -d - -f 1)/*.zip cirrus:$(grep unch $CIRRUS_WORKING_DIR/build_rom.sh -m 1 | cut -d ' ' -f 2 | cut -d _ -f 2 | cut -d - -f 1) -P
