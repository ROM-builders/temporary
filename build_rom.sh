# sync rom
repo init --depth=1 --no-repo-verify -u https://github.com/Evolution-X/manifest -b tiramisu -g default,-mips,-darwin,-notdefault
git clone https://github.com/aaravmujawdia/local_manifests.git --depth 1 -b ysl .repo/local_manifests
repo sync -c --no-clone-bundle --no-tags --optimized-fetch --prune --force-sync -j8

# build rom
source build/envsetup.sh
lunch evolution_ysl-userdebug
export KBUILD_BUILD_USER=krishna 
export KBUILD_BUILD_HOST=krishnaspeace 
export BUILD_USERNAME=krisha
export BUILD_HOSTNAME=krishnaspeace
export BUILD_BROKEN_MISSING_REQUIRED_MODULES=tru
export TZ=Asia/Dhaka #put before last build command
mka evolution

# upload rom (if you don't need to upload multiple files, then you don't need to edit next line)
rclone copy out/target/product/$(grep unch $CIRRUS_WORKING_DIR/build_rom.sh -m 1 | cut -d ' ' -f 2 | cut -d _ -f 2 | cut -d - -f 1)/*.zip cirrus:$(grep unch $CIRRUS_WORKING_DIR/build_rom.sh -m 1 | cut -d ' ' -f 2 | cut -d _ -f 2 | cut -d - -f 1) -P
