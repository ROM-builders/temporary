# sync rom
repo init --depth=1 --no-repo-verify -u https://github.com/crdroidandroid/android -b 13.0 -g default,-mips,-darwin,-notdefault
git clone https://github.com/Idkanythin07 --depth 1 -b CrDroid .repo/local_manifests
repo sync -c --no-clone-bundle --no-tags --optimized-fetch --prune --force-sync -j8

# build rom

source build/envsetup.sh

export BUILD_USER=IdkAnythin07
export BUILD_USERNAME=IdkAnythin07
export KBUILD_BUILD_USER=IdkAnythin07
export KBUILD_BUILD_USERNAME=IdkAnythin07
export BUILD_HOST=cirrus-ci
export BUILD_HOSTNAME=cirrus-ci

export WITH_GAPPS=true
export TARGET_DISABLE_EPPE :=true
export TZ=Asia/Dhaka #put before last build command

brunch RMX1941

# upload rom (if you don't need to upload multiple files, then you don't need to edit next line)
rclone copy out/target/product/$(grep unch $CIRRUS_WORKING_DIR/build_rom.sh -m 1 | cut -d ' ' -f 2 | cut -d _ -f 2 | cut -d - -f 1)/*.zip cirrus:$(grep unch $CIRRUS_WORKING_DIR/build_rom.sh -m 1 | cut -d ' ' -f 2 | cut -d _ -f 2 | cut -d - -f 1) -P
