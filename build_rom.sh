# sync rom
repo init --depth=1 --no-repo-verify -u git://github.com/The-RAVEN-OS/manifest -b twelve -g default,-mips,-darwin,-notdefault
git clone https://github.com/Hyperizer69/local_manifest.git --depth 1 -b main .repo/local_manifests
repo sync -c --no-clone-bundle --no-tags --optimized-fetch --prune --force-sync -j8

# build rom
. build/envsetup.sh
lunch fuse_RMX1851-userdebug
export ALLOW_MISSING_DEPENDENCIES=true
export TZ=Asia/Kolkata #put before last build command
make fuse-prod 

# upload rom (if you don't need to upload multiple files, then you don't need to edit next line)
rclone copy out/target/product/$(grep unch $CIRRUS_WORKING_DIR/build_rom.sh -m 1 | cut -d ' ' -f 2 | cut -d _ -f 2 | cut -d - -f 1)/*.zip cirrus:$(grep unch $CIRRUS_WORKING_DIR/build_rom.sh -m 1 | cut -d ' ' -f 2 | cut -d _ -f 2 | cut -d - -f 1) -P


