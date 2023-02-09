# DEVICE TREE
git clone https://github.com/anandhan07/android_device_xiaomi_vince -b ricedroid-13.0 device/xiaomi/vince

# VENDOR TREE
git clone https://github.com/anandhan07/android_vendor_xiaomi_vince -b 13.0 vendor/xiaomi/vince

# KERNEL TREE
git clone https://github.com/GhostMaster69-dev/android_kernel_xiaomi_vince -b master kernel/xiaomi/vince

# CLANG
git clone --depth=1 https://gitlab.com/anandhan07/aosp-clang.git -b clang-15.0.3 prebuilts/clang/host/linux-x86/clang-r468909b

# sync rom
# Setup source
repo init --depth=1 --no-repo-verify -u https://github.com/ricedroidOSS/android -b thirteen -g default,-mips,-darwin,-notdefault

# Fetch source
repo sync -c --no-clone-bundle --force-remove-dirty --optimized-fetch --prune --force-sync -j8

# build rom
source build/envsetup.sh
export WITH_GAPPS=true
lunch lineage_vince-user
export TZ=Asia/Dhaka #put before last build command
mka bacon

# upload rom (if you don't need to upload multiple files, then you don't need to edit next line)
rclone copy out/target/product/$(grep unch $CIRRUS_WORKING_DIR/build_rom.sh -m 1 | cut -d ' ' -f 2 | cut -d _ -f 2 | cut -d - -f 1)/*.zip cirrus:$(grep unch $CIRRUS_WORKING_DIR/build_rom.sh -m 1 | cut -d ' ' -f 2 | cut -d _ -f 2 | cut -d - -f 1) -P
