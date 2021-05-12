# sync rom
repo init --depth=1 -u https://github.com/PixelExperience/manifest -b eleven-plus -g default,-device,-mips,-darwin,-notdefault
git clone https://github.com/DhruvChhura/mainfest_personal.git --depth=1 -b pe .repo/local_manifests
repo sync -c --no-clone-bundle --no-tags --optimized-fetch --prune --force-sync -j$(nproc --all)

# build rom
source build/envsetup.sh
export ALLOW_MISSING_DEPENDENCIES=true
lunch aosp_ysl-user
make bacon

# upload rom
rclone copy out/target/product/ysl/*.zip cirrus:$(grep unch $CIRRUS_WORKING_DIR/build_rom.sh -m 1 | cut -d _ -f 2 | cut -d - -f 1) -P
