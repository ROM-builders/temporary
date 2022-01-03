# sync rom
repo init --depth=1 --no-repo-verify -u https://github.com/Komodo-OS/manifest -b 12 -g default,-mips,-darwin,-notdefault
git clone https://github.com/TelkomFlexi/local_manifest --depth 1 -b komodo .repo/local_manifests
repo sync -c --no-clone-bundle --no-tags --optimized-fetch --prune --force-sync -j12

# build rom
source build/envsetup.sh
lunch komodo_ginkgo-userdebug
export BUILD_USERNAME=ramaa
export BUILD_HOSTNAME=ramaa
export TZ=Asia/Jakarta
export ALLOW_MISSING_DEPENDENCIES=true
mka komodo

# upload rom (if you don't need to upload multiple files, then you don't need to edit next line)
rclone copy out/target/product/$(grep unch $CIRRUS_WORKING_DIR/build_rom.sh -m 1 | cut -d ' ' -f 2 | cut -d _ -f 2 | cut -d - -f 1)/*.zip cirrus:$(grep unch $CIRRUS_WORKING_DIR/build_rom.sh -m 1 | cut -d ' ' -f 2 | cut -d _ -f 2 | cut -d - -f 1) -P
