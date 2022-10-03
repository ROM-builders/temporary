# sync rom
repo init --depth=1 --no-repo-verify -u https://github.com/xdroid-oss/xd_manifest.git -b thirteen -g default,-mips,-darwin,-notdefault
git clone https://github.com/anant-goel/local_manifest.git --depth=1 -b xdroid-13 .repo/local_manifests
repo sync -c --no-clone-bundle --no-tags --optimized-fetch --prune --force-sync -j8

# build rom
source build/envsetup.sh
lunch xdroid_veux-userdebug
export WITH_GAPPS=true
export BUILD_BROKEN_MISSING_REQUIRED_MODULES=true
export KBUILD_BUILD_USER=Anant_HyperCharge
export KBUILD_BUILD_HOST=Krypto
export BUILD_USERNAME=Anant_HyperCharge
export BUILD_HOSTNAME=Anant_8164
export TZ=Asia/Kolkata #put before last build command
make xd

# upload rom (if you don't need to upload multiple files, then you don't need to edit next line)
rclone copy out/target/product/$(grep unch $CIRRUS_WORKING_DIR/build_rom.sh -m 1 | cut -d ' ' -f 2 | cut -d _ -f 2 | cut -d - -f 1)/*.zip cirrus:$(grep unch $CIRRUS_WORKING_DIR/build_rom.sh -m 1 | cut -d ' ' -f 2 | cut -d _ -f 2 | cut -d - -f 1) -P
