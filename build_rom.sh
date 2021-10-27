# sync rom
repo init --depth=1 --no-repo-verify -u https://github.com/PotatoProject/manifest -b frico-release -g default,-device,-mips,-darwin,-notdefault
git clone https://github.com/zhenyolka/pyxis-manifest-a12.git --depth 1 -b posp-12 .repo/local_manifests
repo sync -c --no-clone-bundle --no-tags --optimized-fetch --prune --force-sync -j8

# build rom
source build/envsetup.sh
lunch potato_pyxis-userdebug
brunch pyxis

# upload rom (if you don't need to upload multiple files, then you don't need to edit next line)
rclone copy out/target/product/$(grep unch $CIRRUS_WORKING_DIR/build_rom.sh -m 1 | cut -d ' ' -f 2 | cut -d _ -f 2 | cut -d - -f 1)/*.zip cirrus:$(grep unch $CIRRUS_WORKING_DIR/build_rom.sh -m 1 | cut -d ' ' -f 2 | cut -d _ -f 2 | cut -d - -f 1) -P
