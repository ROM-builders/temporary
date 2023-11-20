# sync rom
repo init --depth=1 --no-repo-verify -u https://github.com/Evolution-X/manifest -b udc -g default,-mips,-darwin,-notdefault
git clone https://github.com/Muichiro09/local_manifest.git --depth 1 -b 14 .repo/local_manifests
repo sync -c --no-clone-bundle --no-tags --optimized-fetch --prune --force-sync -j8

# build rom
source build/envsetup.sh
lunch evolution_surya-userdebug
export KBUILD_BUILD_USER=Muichiro09
export TZ=Asia/Manila #put before last build command 
mka evolution

# upload rom (if you don't need to upload multiple files, then you don't need to edit next line)
rclone copy out/target/product/$(grep unch $CIRRUS_WORKING_DIR/build_rom.sh -m 1 | cut -d ' ' -f 2 | cut -d _ -f 2 | cut -d - -f 1)/*.zip cirrus:$(grep unch $CIRRUS_WORKING_DIR/build_rom.sh -m 1 | cut -d ' ' -f 2 | cut -d _ -f 2 | cut -d - -f 1) -P
