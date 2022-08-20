# sync rom
repo init --depth=1 --no-repo-verify -u https://github.com/Corvus-R/android_manifest.git -b 12-test -g default,-mips,-darwin,-notdefault
git clone https://github.com/dtyghc/local_manifest.git --depth=1 -b corvus .repo/local_manifests
repo sync -c --no-clone-bundle --no-tags --optimized-fetch --prune --force-sync -j8

# build rom
source build/envsetup.sh
lunch corvus_olives-userdebug
export WITH_GAPPS=true
export KBUILD_BUILD_USER=Anant
export KBUILD_BUILD_HOST=81
export BUILD_USERNAME=Anant_1
export BUILD_HOSTNAME=81
export TZ=Asia/Dhaka #put before last build command
make corvus

# upload rom (if you don't need to upload multiple files, then you don't need to edit next line)
rclone copy out/target/product/$(grep unch $CIRRUS_WORKING_DIR/build_rom.sh -m 1 | cut -d ' ' -f 2 | cut -d _ -f 2 | cut -d - -f 1)/*.zip cirrus:$(grep unch $CIRRUS_WORKING_DIR/build_rom.sh -m 1 | cut -d ' ' -f 2 | cut -d _ -f 2 | cut -d - -f 1) -P
