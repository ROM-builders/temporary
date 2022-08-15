# sync rom
repo init -u https://github.com/Project-Fluid/manifest.git -b fluid-12.1 -g default,-mips,-darwin,-notdefault
git clone https://github.com/abhishekhembrom08/local_manifest.git --depth 1 -b master .repo/local_manifests
repo sync --force-sync --no-tags --no-clone-bundle -j$(nproc --all)

# build rom
source build/envsetup.sh
lunch fluid_ginkgo-userdebug
export TZ=Asia/Kolkata #put before last build command
mka bacon

# upload rom (if you don't need to upload multiple files, then you don't need to edit next line)
rclone copy out/target/product/$(grep unch $CIRRUS_WORKING_DIR/build_rom.sh -m 1 | cut -d ' ' -f 2 | cut -d _ -f 2 | cut -d - -f 1)/*.zip cirrus:$(grep unch $CIRRUS_WORKING_DIR/build_rom.sh -m 1 | cut -d ' ' -f 2 | cut -d _ -f 2 | cut -d - -f 1) -P


