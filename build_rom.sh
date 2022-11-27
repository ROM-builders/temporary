# sync rom
repo init --depth=1 --no-repo-verify -u https://github.com/Evolution-X/manifest.git -b tiramisu -g default,-mips,-darwin,-notdefault
git clone https://gitlab.com/R9Lab/Manifest.git --depth 1 -b EvoX-13 .repo/local_manifests
repo sync -c --no-clone-bundle --no-tags --optimized-fetch --prune --force-sync -j8

# build rom
source build/envsetup.sh
lunch evolution_lava-userdebug
export SELINUX_IGNORE_NEVERALLOWS=true
export KBUILD_BUILD_USER=Orkun
export KBUILD_BUILD_HOST=Cirrus 
export BUILD_USERNAME=Orkun
export BUILD_HOSTNAME=Cirrus
export TZ=Europe/Istanbul #put before last build command
mka evolution

# upload rom (if you don't need to upload multiple files, then you don't need to edit next line)
rclone copy out/target/product/$(grep unch $CIRRUS_WORKING_DIR/build_rom.sh -m 1 | cut -d ' ' -f 2 | cut -d _ -f 2 | cut -d - -f 1)/*.zip cirrus:$(grep unch $CIRRUS_WORKING_DIR/build_rom.sh -m 1 | cut -d ' ' -f 2 | cut -d _ -f 2 | cut -d - -f 1) -P
