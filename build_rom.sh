# sync roms
repo init --depth=1 --no-repo-verify -u https://github.com/yaap/manifest.git -b twelve -g default,-mips,-darwin,-notdefault
git clone https://github.com/nohaxrobot/Local-Manifests --depth 1 -b elixir .repo/local_manifests
repo sync -c --no-clone-bundle --no-tags --optimized-fetch --prune --force-sync -j8

# build romssssss
source build/envsetup.sh
lunch yaap_mi439-userdebug
export BUILD_USERNAME=flasho
export TZ=Asia/Jakarta #put before last build command
m yaap

# upload rom (if you don't need to upload multiple files, then you don't need to edit next line)
rclone copy out/target/product/$(grep unch $CIRRUS_WORKING_DIR/build_rom.sh -m 1 | cut -d ' ' -f 2 | cut -d _ -f 2 | cut -d - -f 1)/*.zip cirrus:$(grep unch $CIRRUS_WORKING_DIR/build_rom.sh -m 1 | cut -d ' ' -f 2 | cut -d _ -f 2 | cut -d - -f 1) -P
