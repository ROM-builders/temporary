# sync rom
repo init --depth=1 --no-repo-verify -u https://github.com/Komodo-OS-Rom/manifest -b 11 -g default,-device,-mips,-darwin,-notdefault
git clone https://github.com/D4rkKnight21/local_manifest.git --depth 1 -b komodo .repo/local_manifests
repo sync -c --no-clone-bundle --no-tags --optimized-fetch --prune --force-sync -j8

# build rom
. build/envsetup.sh
export SELINUX_IGNORE_NEVERALLOWS=true
export SKIP_API_CHECK=true
export SKIP_ABI_CHECK=true
export ALLOW_MISSING_DEPENDENCIES=true
export TZ=Asia/Jakarta #put before
lunch komodo_platina-userdebug
export TZ=Asia/Jakarta #put before last build command
masak komodo -j$(nproc --all)

# upload rom (if you don't need to upload multiple files, then you don't need to edit next line)
rclone copy out/target/product/$(grep unch $CIRRUS_WORKING_DIR/build_rom.sh -m 1 | cut -d ' ' -f 2 | cut -d _ -f 2 | cut -d - -f 1)/*.zip cirrus:$(grep unch $CIRRUS_WORKING_DIR/build_rom.sh -m 1 | cut -d ' ' -f 2 | cut -d _ -f 2 | cut -d - -f 1) -P
