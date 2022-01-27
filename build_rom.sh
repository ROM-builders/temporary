# sync rom
repo init --depth=1 --no-repo-verify -u repo init --depth=1 --no-repo-verify -u https://github.com/conquerOS/manifest.git -b twelve -g default,-mips,-darwin,-notdefault
git clone https://github.com/Atharv2951-Roms/Local-Manifests -b main .repo/local_manifests
repo sync -c --no-clone-bundle --no-tags --optimized-fetch --prune --force-sync -j8

# build rom
. build/envsetup.sh
lunch conquer_selene-userdebug
export ALLOW_MISSING_DEPENDENCES=true
export SELINUX_IGNORE_NEVERALLOWS=true
export TZ=Asia/Mumbai #put before last build command
make carthage

# upload rom (if you don't need to upload multiple files, then you don't need to edit next line)
rclone copy out/target/product/$(grep unch $CIRRUS_WORKING_DIR/build_rom.sh -m 1 | cut -d ' ' -f 2 | cut -d _ -f 2 | cut -d - -f 1)/*.zip cirrus:$(grep unch $CIRRUS_WORKING_DIR/build_rom.sh -m 1 | cut -d ' ' -f 2 | cut -d _ -f 2 | cut -d - -f 1) -P
