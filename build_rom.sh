# sync rom
repo init --depth=1 --no-repo-verify -u https://github.com/AOSPA/manifest -b sapphire -g default,-mips,-darwin,-notdefault
git clone https://github.com/z3zens/local_manifest.git --depth 1 -b sapphire .repo/local_manifests
repo sync -c --no-clone-bundle --no-tags --optimized-fetch --prune --force-sync -j8

# build rom AOSPA sapphire  
source build/envsetup.sh
lunch aospa_X01BD-userdebug
export BUILD_USERNAME=nobody
export BUILD_HOSTNAME=android-build
export KBUILD_BUILD_USER=nobody
export KBUILD_BUILD_HOST=android-build
export TZ=Asia/Jakarta
./rom-build.sh X01BD -c -t userdebug -v beta

# upload rom
rclone copy out/target/product/$(grep unch $CIRRUS_WORKING_DIR/build_rom.sh -m 1 | cut -d ' ' -f 2 | cut -d _ -f 2 | cut -d - -f 1)/*.zip cirrus:$(grep unch $CIRRUS_WORKING_DIR/build_rom.sh -m 1 | cut -d ' ' -f 2 | cut -d _ -f 2 | cut -d - -f 1) -P
