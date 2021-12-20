# sync rom
repo init --depth=1 --no-repo-verify -u git://github.com/Octavi-OS/platform-manifest.git -b 12 -g default,-mips,-darwin,-notdefault
git clone https://github.com/K-fear/Local-Manifests.git --depth 1 -b octavi-mido .repo/local_manifests
repo sync -c --no-clone-bundle --no-tags --optimized-fetch --prune --force-sync -j8

# build rom
source build/envsetup.sh
lunch octavi_mido-userdebug
export TZ=Asia/Jakarta
export BUILD_USER=cirrus
export BUILD_HOST=mido
export BUILD_USERNAME=cirrus
export BUILD_HOSTNAME=mido
mka derp

# upload rom (if you don't need to upload multiple files, then you don't need to edit next line)
rclone copy out/target/product/$(grep unch $CIRRUS_WORKING_DIR/build_rom.sh -m 1 | cut -d ' ' -f 2 | cut -d _ -f 2 | cut -d - -f 1)/*.zip cirrus:$(grep unch $CIRRUS_WORKING_DIR/build_rom.sh -m 1 | cut -d ' ' -f 2 | cut -d _ -f 2 | cut -d - -f 1) -P
