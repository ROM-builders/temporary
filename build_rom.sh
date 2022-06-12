# sync rom
repo init --depth=1 --no-repo-verify -u https://github.com/VoltageOS/manifest -b 12l -g default,-mips,-darwin,-notdefault
git clone https://github.com/ritvik-ch/local_manifest.git --depth 1 -b voltage-12.x .repo/local_manifests
repo sync -c --no-clone-bundle --no-tags --optimized-fetch --prune --force-sync -j8


# build rom
source build/envsetup.sh
export KBUILD_BUILD_USER=Ritvik
export KBUILD_BUILD_HOST=ritvik
export BUILD_USERNAME=Ritvik
export BUILD_HOSTNAME=ritvik
export SELINUX_IGNORE_NEVERALLOWS=true 
export TZ=Asia/Delhi
brunch voltage_vince-userdebug

# upload rom (if you don't need to upload multiple files, then you don't need to edit next line)
rclone copy out/target/product/$(grep unch $CIRRUS_WORKING_DIR/build_rom.sh -m 1 | cut -d ' ' -f 2 | cut -d _ -f 2 | cut -d - -f 1)/*.zip cirrus:$(grep unch $CIRRUS_WORKING_DIR/build_rom.sh -m 1 | cut -d ' ' -f 2 | cut -d _ -f 2 | cut -d - -f 1) -P
rclone copy vendor/ota/vince.json cirrus:vince -P
