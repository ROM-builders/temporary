# sync rom
repo init --depth=1 --no-repo-verify -u https://github.com/Evolution-X/manifest -b tiramisu --depth 1 -g default,-mips,-darwin,-notdefault
git clone https://github.com/weaponmasterjax/local_manifest.git --depth 1 -b Evox-v2 .repo/local_manifests
repo sync -c --no-clone-bundle --no-tags --optimized-fetch --prune --force-sync -j8

# build rom
source build/envsetup.sh
export TZ=Asia/Chungking #put before last build command
export BUILD_USERNAME=weaponmasterjax
export BUILD_HOSTNAME=jax
lunch evolution_everpal-userdebug
mka evolution

# upload rom (if you don't need to upload multiple files, then you don't need to edit next line)
rclone copy out/target/product/$(grep unch $CIRRUS_WORKING_DIR/build_rom.sh -m 1 | cut -d ' ' -f 2 | cut -d _ -f 2 | cut -d - -f 1)/*.zip cirrus:$(grep unch $CIRRUS_WORKING_DIR/build_rom.sh -m 1 | cut -d ' ' -f 2 | cut -d _ -f 2 | cut -d - -f 1) -P
rclone copy out/target/product/everpal/*.zip.json cirrus:everpal -P

