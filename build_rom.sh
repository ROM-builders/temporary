# sync rom
repo init --depth=1 --no-repo-verify -u https://github.com/CipherOS/android_manifest.git -b twelve-L -g default,-mips,-darwin,-notdefault
git clone https://github.com/AzurE-007/local_manifests.git --depth 1 -b cipher .repo/local_manifests
repo sync -c --no-clone-bundle --no-tags --optimized-fetch --prune --force-sync -j8

# build rom
export ALLOW_MISSING_DEPENDENCIES=tru
export SELINUX_IGNORE_NEVERALLOWS=true
source build/envsetup.sh
lunch cipher_raphael-userdebug
export TZ=Asia/Delhi #put before last build command
make bacon

# upload rom (if you don't need to upload multiple files, then you don't need to edit next line)
rclone copy out/target/product/$(grep unch $CIRRUS_WORKING_DIR/build_rom.sh -m 1 | cut -d ' ' -f 2 | cut -d _ -f 2 | cut -d - -f 1)/*.zip cirrus:$(grep unch $CIRRUS_WORKING_DIR/build_rom.sh -m 1 | cut -d ' ' -f 2 | cut -d _ -f 2 | cut -d - -f 1) -P
