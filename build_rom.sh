# sync rom
repo init --depth=1 --no-repo-verify -u git://github.com/Komodo-OS/manifest -b 12 -g default,-mips,-darwin,-notdefault
git clone https://github.com/WisnuArdhi28/local_manifests.git --depth 1 -b a12 .repo/local_manifests
repo sync -c --no-clone-bundle --no-tags --optimized-fetch --prune --force-sync -j8

# build rom3
source build/envsetup.sh
lunch komodo_ginkgo-userdebug
export TZ=Asia/Jakarta #put before last build command
mka komodo

# upload rom (if you don't need to upload multiple files, then you don't need to edit next line)
rclone copy out/target/product/$(grep unch $CIRRUS_WORKING_DIR/build_rom.sh -m 1 | cut -d ' ' -f 2 | cut -d _ -f 2 | cut -d - -f 1)/*.zip cirrus:$(grep unch $CIRRUS_WORKING_DIR/build_rom.sh -m 1 | cut -d ' ' -f 2 | cut -d _ -f 2 | cut -d - -f 1) -P
