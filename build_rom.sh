# sync rom
repo init --depth=1 --no-repo-verify -u https://github.com/P-404/android_manifest -b tokui -g default,-mips,-darwin,-notdefault
git clone https://github.com/Mozzaru/local_manifest.git --depth 1 -b p404-T .repo/local_manifests
repo sync -c --no-clone-bundle --no-tags --optimized-fetch --prune --force-sync -j8

# build rom  
source build/envsetup.sh
lunch p404_markw-userdebug
export KBUILD_BUILD_USER=Van.
export KBUILD_BUILD_HOST=Van.
export BUILD_USERNAME=Van.
export BUILD_HOSTNAME=Van.
export TZ=Asia/Jakarta #put before last build command
mka bacon

# upload rom (if you don't need to upload multiple files, then you don't need to edit next line)
rclone copy out/target/product/$(grep unch $CIRRUS_WORKING_DIR/build_rom.sh -m 1 | cut -d ' ' -f 2 | cut -d _ -f 2 | cut -d - -f 1)/*.zip cirrus:$(grep unch $CIRRUS_WORKING_DIR/build_rom.sh -m 1 | cut -d ' ' -f 2 | cut -d _ -f 2 | cut -d - -f 1) -P
