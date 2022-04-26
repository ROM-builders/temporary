# sync rom
repo init --depth=1 --no-repo-verify -u https://github.com/ProjectBlaze/manifest.git -b 12.1 -g default,-mips,-darwin,-notdefault
git clone https://github.com/JaswantTeja/local_manifest.git --depth 1 -b blaze .repo/local_manifest
repo sync -c -j$(nproc --all) --force-sync --optimized-fetch --no-tags --no-clone-bundle --prune

# build rom
. build/envsetup.sh
lunch blaze_r5x-userdebug
export SELINUX_IGNORE_NEVERALLOWS=true
export TZ=Asia/Delhi #put before last build command
brunch r5x

# upload rom (if you don't need to upload multiple files, then you don't need to edit next line)
rclone copy out/target/product/$(grep unch $CIRRUS_WORKING_DIR/build_rom.sh -m 1 | cut -d ' ' -f 2 | cut -d _ -f 2 | cut -d - -f 1)/*.zip cirrus:$(grep unch $CIRRUS_WORKING_DIR/build_rom.sh -m 1 | cut -d ' ' -f 2 | cut -d _ -f 2 | cut -d - -f 1) -P
