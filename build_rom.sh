# sync rom
repo init --depth=1 --no-repo-verify -u https://github.com/Spark-Rom/manifest -b pyro -g default,-mips,-darwin,-notdefault
git clone https://github.com/JuanTamadski/local_manifest.git --depth 1 -b pyro .repo/local_manifests
git clone --depth=1 https://github.com/Edward-Projects/gcc-arm64 -b Z01R prebuilts/gcc/linux-x86/aarch64/aarch64-elf
git clone --depth=1 https://github.com/Edward-Projects/gcc-arm -b Z01R prebuilts/gcc/linux-x86/arm/arm-eabi
repo sync -c --no-clone-bundle --no-tags --optimized-fetch --prune --force-sync -j8

# build rom
source build/envsetup.sh
lunch spark_Z01R-userdebug
export TZ=Asia/Kolkata 
export SELINUX_IGNORE_NEVERALLOWS=true
mka bacon

# upload rom (if you don't need to upload multiple files, then you don't need to edit next line)
rclone copy out/target/product/$(grep unch $CIRRUS_WORKING_DIR/build_rom.sh -m 1 | cut -d ' ' -f 2 | cut -d _ -f 2 | cut -d - -f 1)/*.zip cirrus:$(grep unch $CIRRUS_WORKING_DIR/build_rom.sh -m 1 | cut -d ' ' -f 2 | cut -d _ -f 2 | cut -d - -f 1) -P
