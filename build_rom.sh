# sync
repo init --depth=1 --no-repo-verify -u https://github.com/Komodo-OS/manifest -b 12.1 -g default,-mips,-darwin,-notdefault
git clone https://github.com/megumin775/Local-Manifests.git --depth 1 -b komodo-12.1 .repo/local_manifests
repo sync -c --no-clone-bundle --no-tags --optimized-fetch --prune --force-sync -j8

# build 
build/envsetup.sh
lunch komodo_X00TD-userdebug
export TZ=Asia/Jakarta
export BUILD_USER=chunchunmaru
export BUILD_USERNAME=megumin
export SELINUX_IGNORE_NEVERALLOWS=true
export ALLOW_MISSING_DEPENDENCIES=true
export RELAX_USES_LIBRARY_CHECK=true
mka komodo

# upload rom (if you don't need to upload multiple files, then you don't need to edit next line)
rclone copy out/target/product/$(grep unch $CIRRUS_WORKING_DIR/build_rom.sh -m 1 | cut -d ' ' -f 2 | cut -d _ -f 2 | cut -d - -f 1)/*.zip cirrus:$(grep unch $CIRRUS_WORKING_DIR/build_rom.sh -m 1 | cut -d ' ' -f 2 | cut -d _ -f 2 | cut -d - -f 1) -P
