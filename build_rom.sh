# sync rom
repo init --depth=1 --no-repo-verify -u https://github.com/crdroidandroid/android.git -b 13.0 --git-lfs -g default,-mips,-darwin,-notdefault
git clone https://github.com/Koushikdey2003/local_manifest.git --depth 1 -b crDroid-13.0 .repo/local_manifests
repo sync -c --no-clone-bundle --no-tags --optimized-fetch --prune --force-sync -j8

# build rom
source build/envsetup.sh

export BUILD_USER=Koushikdey2003
export BUILD_USERNAME=Koushikdey2003
export KBUILD_BUILD_USER=Koushikdey2003
export KBUILD_BUILD_USERNAME=Koushikdey2003
export BUILD_HOST=cirrus-ci
export BUILD_HOSTNAME=cirrus-ci

export TZ=Asia/Kolkata #put before last build command
export ARROW_GAPPS=true

brunch RMX2020

# upload rom (if you don't need to upload multiple files, then you don't need to edit next line)
rclone copy out/target/product/$(grep unch $CIRRUS_WORKING_DIR/build_rom.sh -m 1 | cut -d ' ' -f 2 | cut -d _ -f 2 | cut -d - -f 1)/*.zip cirrus:$(grep unch $CIRRUS_WORKING_DIR/build_rom.sh -m 1 | cut -d ' ' -f 2 | cut -d _ -f 2 | cut -d - -f 1) -P
