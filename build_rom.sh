# sync rom
repo init --depth=1 --no-repo-verify -u git://github.com/DotOS/manifest.git -b dot12.1 -g default,-mips,-darwin,-notdefault
#git clone https://github.com/jash69/local-manifests.git --depth 1 -b main .repo/local_manifests          #fix branch name
git clone https://github.com/jash69/device_xiaomi_sweet -b dot12 --depth=1 device/xiaomi/sweet
git clone https://github.com/jash69/device_xiaomi_sm6150-common-dotOS -b twelve --depth=1 device/xiaomi/sm6150-common
git clone https://github.com/PixelOS-Devices/vendor_xiaomi -b twelve --depth=1 vendor/xiaomi
git clone https://github.com/PixelOS-Devices/kernel_xiaomi_sm6150 -b courbet-12.1 --depth=1 kernel/xiaomi/sm6150
git clone https://gitlab.com/PixelOS-Devices/playgroundtc -b 15 --depth=1 prebuilts/clang/host/linux-x86/clang-playground
repo sync -c --no-clone-bundle --no-tags --optimized-fetch --prune --force-sync -j8

# build rom
source build/envsetup.sh
lunch dot_sweet-user
export TZ=Asia/Dhaka #put before last build command
make bacon

# upload rom (if you don't need to upload multiple files, then you don't need to edit next line)
rclone copy out/target/product/$(grep unch $CIRRUS_WORKING_DIR/build_rom.sh -m 1 | cut -d ' ' -f 2 | cut -d _ -f 2 | cut -d - -f 1)/*.zip cirrus:$(grep unch $CIRRUS_WORKING_DIR/build_rom.sh -m 1 | cut -d ' ' -f 2 | cut -d _ -f 2 | cut -d - -f 1) -P
