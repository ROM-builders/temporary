# sync rom
repo init --depth=1 --no-repo-verify -u https://github.com/Corvus-AOSP/android_manifest.git -b 13 -g default,-mips,-darwin,-notdefault
git clone https://github.com/Notkerd69/local_manifest.git --depth 1 -b cobus-quetejodan .repo/local_manifests
repo sync -c --no-clone-bundle --no-tags --optimized-fetch --prune --force-sync -j8

# build rom
export KBUILD_BUILD_USER=Notkerd69
export KBUILD_BUILD_HOST=cirrushet
export BUILD_USERNAME=Notkerd69
export BUILD_HOSTNAME=cirrushet
source build/envsetup.sh
lunch corvus_fog-userdebug
export TZ=America/Caracas #put before last build command
make corvus

# upload rom (if you don't need to upload multiple files, then you don't need to edit next line)
rclone copy out/target/product/$(grep unch $CIRRUS_WORKING_DIR/build_rom.sh -m 1 | cut -d ' ' -f 2 | cut -d _ -f 2 | cut -d - -f 1)/*.zip cirrus:$(grep unch $CIRRUS_WORKING_DIR/build_rom.sh -m 1 | cut -d ' ' -f 2 | cut -d _ -f 2 | cut -d - -f 1) -P
