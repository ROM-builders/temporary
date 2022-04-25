# sync rom
repo init --depth=1 --no-repo-verify -u https://github.com/SwiftOS-DROID/android_manifest.git -b 12 -g default,-mips,-darwin,-notdefault
git clone https://github.com/JaswantTeja/local_manifest.git --depth 1 -b Swift .repo/local_manifest
repo sync -c --force-sync --optimized-fetch --no-tags --no-clone-bundle --prune -j$(nproc --all);

# build rom
. build/envsetup.sh
lunch swift_r5x-userdebug
export SELINUX_IGNORE_NEVERALLOWS=true
export TZ=Asia/Kolkata #put before last build command
mka swift

# upload rom (if you don't need to upload multiple files, then you don't need to edit next line)
rclone copy out/target/product/$(grep unch $CIRRUS_WORKING_DIR/build_rom.sh -m 1 | cut -d ' ' -f 2 | cut -d _ -f 2 | cut -d - -f 1)/*.zip cirrus:$(grep unch $CIRRUS_WORKING_DIR/build_rom.sh -m 1 | cut -d ' ' -f 2 | cut -d _ -f 2 | cut -d - -f 1) -P
