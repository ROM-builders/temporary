# sync rom
repo init --depth=1 --no-repo-verify -u git@github.com:Evolution-X/manifest.git -b elle -g default,-device,-mips,-darwin,-notdefault
mkdir -p .repo/kernel/xiaomi
mkdir -p .repo/device/xiaomi
git clone https://github.com/mikairyuu/kernel_xiaomi_sm7250 --depth 1 -b skizo .repo/kernel/xiaomi/sm7250
git clone https://github.com/mikairyuu/android_device_xiaomi_sm7250-common --depth 1 .repo/device/xiaomi/sm7250-common
git clone https://github.com/mikairyuu/android_device_xiaomi_monet-oss --depth 1 .repo/device/xiaomi/monet
git clone https://gitlab.com/mikairyuu/android-vendor-xiaomi-sm7250 --depth 1 .repo/vendor/xiaomi
repo sync -c --no-clone-bundle --no-tags --optimized-fetch --prune --force-sync -j8

# build rom
source build/envsetup.sh
lunch evolution_monet-user
export TZ=Asia/Vladivostok #put before last build command
mka evolution

# upload rom (if you don't need to upload multiple files, then you don't need to edit next line)
rclone copy out/target/product/$(grep unch $CIRRUS_WORKING_DIR/build_rom.sh -m 1 | cut -d ' ' -f 2 | cut -d _ -f 2 | cut -d - -f 1)/*.zip cirrus:$(grep unch $CIRRUS_WORKING_DIR/build_rom.sh -m 1 | cut -d ' ' -f 2 | cut -d _ -f 2 | cut -d - -f 1) -P
