# sync rom
repo init --depth=1 --no-repo-verify -u https://github.com/Project-Xtended/manifest.git -b xt -g default,-mips,-darwin,-notdefault
git clone https://github.com/alecchangod/local_manifest.git --depth 1 -b haydn .repo/local_manifests
repo sync -c --no-clone-bundle --no-tags --optimized-fetch --prune --force-sync -j8
 
# build rom
source build/envsetup.sh
lunch xtended_haydn-userdebug
export BUILD_BROKEN_MISSING_REQUIRED_MODULES=true
export BUILD_USER=alecchangod
export BUILD_USERNAME=alecchangod
export KBUILD_BUILD_USER=alecchangod
export KBUILD_BUILD_USERNAME=alecchangod
export TZ=Asia/Hong_Kong #put before last build command
make xtended

# upload rom (if you don't need to upload multiple files, then you don't need to edit next line)
rclone copy out/target/product/$(grep unch $CIRRUS_WORKING_DIR/build_rom.sh -m 1 | cut -d ' ' -f 2 | cut -d _ -f 2 | cut -d - -f 1)/*.zip cirrus:$(grep unch $CIRRUS_WORKING_DIR/build_rom.sh -m 1 | cut -d ' ' -f 2 | cut -d _ -f 2 | cut -d - -f 1) -P
