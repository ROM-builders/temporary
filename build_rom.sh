# sync rom
repo init --depth=1 --no-repo-verify -u https://github.com/PotatoProject/manifest.git -b frico_mr1-release -g default,-mips,-darwin,-notdefault
git clone https://github.com/lazrdev/local_manifest.git --depth 1 -b potato-12-mi439 .repo/local_manifests
repo sync -c --no-clone-bundle --no-tags --optimized-fetch --prune --force-sync -j8

# build rom
source build/envsetup.sh
lunch potato_mi439-user
export TZ=Asia/Dhaka #put before last build command
brunch mi439

# upload rom (if you don't need to upload multiple files, then you don't need to edit next line)
rclone copy out/target/product/$(grep unch $CIRRUS_WORKING_DIR/build_rom.sh -m 1 | cut -d ' ' -f 2 | cut -d _ -f 2 | cut -d - -f 1)/*.zip cirrus:$(grep unch $CIRRUS_WORKING_DIR/build_rom.sh -m 1 | cut -d ' ' -f 2 | cut -d _ -f 2 | cut -d - -f 1) -P
