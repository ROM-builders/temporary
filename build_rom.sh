# sync rom
repo init --depth=1 --no-repo-verify -u git://github.com/Evolution-X/manifest.git -b elle -g default,-mips,-darwin,-notdefault
git clone https://github.com/Zkyz7/local_manifest.git --depth 1 -b main .repo/local_manifests
repo sync -c --no-clone-bundle --no-tags --optimized-fetch --prune --force-sync -j8

# build rom
wget -q  https://android.googlesource.com/platform/prebuilts/clang/host/linux-x86/+archive/refs/heads/master/clang-r437112b.tar.gz -O "clang-r437112b.tar.gz"
tar -xf clang-r437112b.tar.gz -C prebuilts/clang/host/linux-x86/clang-r437112b
echo "zkyz7@shogun" > kernel/xiaomi/vayu/.builderdata
source build/envsetup.sh
lunch evolution_vayu-userdebug
export TZ=Asia/Dhaka #put before last build command
mka evolution

# upload rom (if you don't need to upload multiple files, then you don't need to edit next line)
rclone copy out/target/product/$(grep unch $CIRRUS_WORKING_DIR/build_rom.sh -m 1 | cut -d ' ' -f 2 | cut -d _ -f 2 | cut -d - -f 1)/*.zip cirrus:$(grep unch $CIRRUS_WORKING_DIR/build_rom.sh -m 1 | cut -d ' ' -f 2 | cut -d _ -f 2 | cut -d - -f 1) -P
