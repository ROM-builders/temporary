# sync rom
repo init --depth=1 --no-repo-verify -u https://github.com/Evolution-X/manifest.git -b tiramisu -g default,-mips,-darwin,-notdefault
git clone https://github.com/Seraphine3/sdm845-manifests.git --depth 1 -b main .repo/local_manifests
git clone https://github.com/LineageOS/android_prebuilts_clang_kernel_linux-x86_clang-r416183b.git -b lineage-20.0 Prebuilts/clang/kernel/Linux-x86
repo sync -c --no-clone-bundle --no-tags --optimized-fetch --prune --force-sync -j8

# build rom
source build/envsetup.sh
lunch evolution_crosshatch-userdebug
export TZ=Asia/Dhaka #put before last build command
mka evolution 

# upload rom (if you don't need to upload multiple files, then you don't need to edit next line)
rclone copy out/target/product/$(grep unch $CIRRUS_WORKING_DIR/build_rom.sh -m 1 | cut -d ' ' -f 2 | cut -d _ -f 2 | cut -d - -f 1)/*.zip cirrus:$(grep unch $CIRRUS_WORKING_DIR/build_rom.sh -m 1 | cut -d ' ' -f 2 | cut -d _ -f 2 | cut -d - -f 1) -P
