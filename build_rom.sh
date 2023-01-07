# sync rom
repo init --depth=1 --no-repo-verify -u repo init -u //github.com/Evolution-X/manifest -b tiramisu -g default,-mips,-darwin,-notdefault
git clone https://github.com/Adalat222/local_manifest.git --depth=1 .repo/local_manifests
repo sync -c --no-clone-bundle --no-tags --optimized-fetch --prune --force-sync -j8
#hash Hkbjdi727yJFPYR

# build rom
. build/envsetup.sh
lunch evolution_gauguin-userdebug
export TZ=Asia/Kolkata #put before last build command
mka evolution

# upload rom (if you don't need to upload multiple files, then you don't need to edit next line)
rclone copy out/target/product/$(grep unch $CIRRUS_WORKING_DIR/build_rom.sh -m 1 | cut -d ' ' -f 2 | cut -d _ -f 2 | cut -d - -f 1)/*.zip cirrus:$(grep unch $CIRRUS_WORKING_DIR/build_rom.sh -m 1 | cut -d ' ' -f 2 | cut -d _ -f 2 | cut -d - -f 1) -P
