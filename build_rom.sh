# sync rom
repo init --depth=1 --no-repo-verify -u https://github.com/Octavi-Staging/manifest.git -b thirteen -g default,-mips,-darwin,-notdefault
repo sync -c --no-clone-bundle --no-tags --optimized-fetch --prune --force-sync -j8

if ! [ -d device/xiaomi/vince ]; then
    git clone --depth=1 -b 13 https://github.com/OctaviOS-Devices/device_xiaomi_vince.git device/xiaomi/vince
else
    rm -rf device/xiaomi/vince
    git clone --depth=1 -b 13 https://github.com/OctaviOS-Devices/device_xiaomi_vince.git device/xiaomi/vince
fi

if ! [ -d prebuilts/clang/host/linux-x86/clang-r450784d ]; then
    git clone --depth=1 -b master https://gitlab.com/Amritorock/clang-r450784d.git prebuilts/clang/host/linux-x86/clang-r450784d
fi

# build rom
source build/envsetup.sh
#export USE_GAPPS=true
#export WITH_GAPPS=true
lunch octavi_vince-user
mka bacon

# upload rom (if you don't need to upload multiple files, then you don't need to edit next line)
rclone copy out/target/product/$(grep unch $CIRRUS_WORKING_DIR/build_rom.sh -m 1 | cut -d ' ' -f 2 | cut -d _ -f 2 | cut -d - -f 1)/*.zip cirrus:$(grep unch $CIRRUS_WORKING_DIR/build_rom.sh -m 1 | cut -d ' ' -f 2 | cut -d _ -f 2 | cut -d - -f 1) -P
