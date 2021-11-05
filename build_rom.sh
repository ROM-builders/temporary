# sync rom
repo init --depth=1 --no-repo-verify -u git://github.com/CipherOS/android_manifest.git -b twelve -g default,-mips,-darwin,-notdefault
git clone https://github.com/sarthakroy2002/local_manifest -b rui2-oss --depth 1 .repo/local_manifests
repo sync -c --no-clone-bundle --no-tags --optimized-fetch --prune --force-sync -j8

# build rom
source build/envsetup.sh
lunch cipher_RMX2020-eng
export TZ=Asia/Dhaka #put before last build command
export SKIP_ABI_CHECKS=true
export SKIP_API_CHECKS=true
export BUILD_HOSTNAME=sarthakroy2002
export BUILD_USERNAME=neolit
mka bacon 

# upload  rom
rclone copy out/target/product/$(grep unch $CIRRUS_WORKING_DIR/build_rom.sh -m 1 | cut -d ' ' -f 2 | cut -d _ -f 2 | cut -d - -f 1)/*.zip cirrus:$(grep unch $CIRRUS_WORKING_DIR/build_rom.sh -m 1 | cut -d ' ' -f 2 | cut -d _ -f 2 | cut -d - -f 1) -P
