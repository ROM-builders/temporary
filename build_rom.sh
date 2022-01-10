# sync rom
repo init --depth=1 --no-repo-verify -u https://github.com/ArrowOS/android_manifest.git -b arrow-11.0 -g default,-mips,-darwin,-notdefault
git clone https://github.com/ibraaltabian17/local_manifest.git --depth 1 -b arrow .repo/local_manifests
repo sync -c --no-clone-bundle --no-tags --optimized-fetch --prune --force-sync -j8

# build rom Arrow
export BUILD_USERNAME="Ibratabian17"
export BUILD_HOSTNAME="EmerlSyc"
BUILD_USER="Ibratabian17"
BUILD_HOST="EmerlSyc"
BUILD_USERNAME="Ibratabian17"
BUILD_HOSTNAME="EmerlSyc"
source build/envsetup.sh
export TZ=Asia/Jakarta #put before last build command
croot
lunch arrow_A6020-userdebug
export BUILD_USERNAME="Ibratabian17"
export BUILD_HOSTNAME="EmerlSyc"
BUILD_USER="Ibratabian17"
BUILD_HOST="EmerlSyc"
BUILD_USERNAME="Ibratabian17"
BUILD_HOSTNAME="EmerlSyc"
mka bacon

# upload rom (if you don't need to upload multiple files, then you don't need to edit next line)
rclone copy out/target/product/$(grep unch $CIRRUS_WORKING_DIR/build_rom.sh -m 1 | cut -d ' ' -f 2 | cut -d _ -f 2 | cut -d - -f 1)/*.zip cirrus:$(grep unch $CIRRUS_WORKING_DIR/build_rom.sh -m 1 | cut -d ' ' -f 2 | cut -d _ -f 2 | cut -d - -f 1) -P
