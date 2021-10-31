# sync rom

repo init --depth=1 --no-repo-verify -u https://github.com/Corvus-R/android_manifest.git -b 11 -g default,-mips,-darwin,-notdefault
git clone https://github.com/phoenix-1708/local_manifest.git -b corvus-11 --depth 1 .repo/local_manifests
repo sync -c --no-clone-bundle --no-tags --optimized-fetch --prune --force-sync -j8

# build rom

source build/envsetup.sh
lunch corvus_sweet-userdebug
export ALLOW_MISSING_DEPENDENCIES=true
export SKIP_ABI_CHECKS=true
export SKIP_API_CHECKS=true
export TZ=Asia/Dhaka #put before last build command
make corvus

# upload rom (if you don't need to upload multiple files, then you don't need to edit next line)
rclone copy out/target/product/$(grep unch $CIRRUS_WORKING_DIR/build_rom.sh -m 1 | cut -d ' ' -f 2 | cut -d _ -f 2 | cut -d - -f 1)/*.zip cirrus:$(grep unch $CIRRUS_WORKING_DIR/build_rom.sh -m 1 | cut -d ' ' -f 2 | cut -d _ -f 2 | cut -d - -f 1) -P
