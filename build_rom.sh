# sync rom
repo init -u https://github.com/CherishOS/android_manifest.git -b qpr3 -g default,-mips,-darwin,-notdefault
git clone https://github.com/YudhoPatrianto/local-manifests.git --depth 1 -b main .repo/local_manifest
repo sync -c --no-clone-bundle --no-tags --optimized-fetch --prune --force-sync -j8

# build rom
source build/envsetup.sh
lunch selene_cherish-userdebug
export ALLOW_MISSING_DEPENDENCIES=true
export SELINUX_INGNORE_NEVERALLOWS=true
export TZ=Asia/Dhaka #put before last build command
brunch selene

# upload rom (if you don't need to upload multiple files, then you don't need to edit next line)
rclone copy out/target/product/$(grep unch $CIRRUS_WORKING_DIR/build_rom.sh -m 1 | cut -d ' ' -f 2 | cut -d _ -f 2 | cut -d - -f 1)/*.zip cirrus:$(grep unch $CIRRUS_WORKING_DIR/build_rom.sh -m 1 | cut -d ' ' -f 2 | cut -d _ -f 2 | cut -d - -f 1) -P
