# sync rom
repo init --depth=1 --no-repo-verify -u https://github.com/PotatoProject/manifest -b frico_mr1-release -g default,-mips,-darwin,-notdefault
git clone https://github.com/progcker/mlocal_manifest.git --depth 1 -b potato .repo/local_manifests
repo sync -c --no-clone-bundle --no-tags --optimized-fetch --prune --force-sync -j8

# build rom
source build/envsetup.sh
export ALLOW_MISSING_DEPENDENCIES=true
export SELINUX_IGNORE_NEVERALLOWS=true
lunch potato_CPH1859-userdebug
export TZ=Asia/Delhi #put before last 
make bacon

# upload rom (if you don't need to upload multiple files, then you don't need to edit next line)
rclone copy out/target/product/$(grep unch $CIRRUS_WORKING_DIR/build_rom.sh -m 1 | cut -d ' ' -f 2 | cut -d _ -f 2 | cut -d - -f 1)/*.zip cirrus:$(grep unch $CIRRUS_WORKING_DIR/build_rom.sh -m 1 | cut -d ' ' -f 2 | cut -d _ -f 2 | cut -d - -f 1) -P
