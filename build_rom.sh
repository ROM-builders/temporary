# sync rom
repo init --depth=1 --no-repo-verify -u git://github.com/CipherOS/android_manifest.git -b twelve-L -g default,-mips,-darwin,-notdefault
git clonehttps://github.com/ok-ano0s/local_manifest.git --depth 1 -b cipher .repo/local_manifests
repo sync -c --no-clone-bundle --no-tags --optimized-fetch --prune --force-sync -j8

# build rom
source build/envsetup.sh
lunch cipher_RMX1941-userdebug
export CIPHER_OFFICIAL=true
export BUILD_HOSTNAME=cArN4gE
export BUILD_USERNAME=ok-ano0s
export TZ=Asia/Dhaka #put before last build command
mka bacon

# upload rom (if you don't need to upload multiple files, then you don't need to edit next line)
rclone copy out/target/product/$(grep unch $CIRRUS_WORKING_DIR/build_rom.sh -m 1 | cut -d ' ' -f 2 | cut -d _ -f 2 | cut -d - -f 1)/*.zip cirrus:$(grep unch $CIRRUS_WORKING_DIR/build_rom.sh -m 1 | cut -d ' ' -f 2 | cut -d _ -f 2 | cut -d - -f 1) -P
