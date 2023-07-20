# sync rom
repo init --depth=1 --no-repo-verify -u https://github.com/Evolution-X/manifest -b tiramisu -g default,-mips,-darwin,-notdefault
git clone https://github.com/dogpoopy/local_manifest.git --depth 1 -b rom-builder .repo/local_manifests
repo sync -c --no-clone-bundle --no-tags --optimized-fetch --prune --force-sync -j8
# set kernel name
sed -i "s/CONFIG_LOCALVERSION=.*/CONFIG_LOCALVERSION="-coup-de-grace"/g" $(shell pwd)/kernel/xiaomi/vayu/arch/arm64/configs/vayu_user_defconfig
# build rom
source build/envsetup.sh
lunch evolution_vayu-user

export ALLOW_MISSING_DEPENDENCIES=true
export TZ=Asia/Manila #put before last build command
mka evolution

# upload rom (if you don't need to upload multiple files, then you don't need to edit next line)
rclone copy out/target/product/$(grep unch $CIRRUS_WORKING_DIR/build_rom.sh -m 1 | cut -d ' ' -f 2 | cut -d _ -f 2 | cut -d - -f 1)/*.zip cirrus:$(grep unch $CIRRUS_WORKING_DIR/build_rom.sh -m 1 | cut -d ' ' -f 2 | cut -d _ -f 2 | cut -d - -f 1) -P
