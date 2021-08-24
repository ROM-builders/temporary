# sync rom
repo init --depth=1 --no-repo-verify -u git://github.com/AOSiP/platform_manifest.git -b eleven -g default,-device,-mips,-darwin,-notdefault
git clone https://github.com/kanup4m/local_manifest.git --depth 1 -b master .repo/local_manifests
repo sync -c --no-clone-bundle --no-tags --optimized-fetch --prune --force-sync -j8


# build rom
source build/envsetup.sh
lunch lineage_rmx2030
export TZ=Asia/Kolkata #put before last build command
time m rmx2030

# upload rom (if you don't need to upload multiple files, then you don't need to edit next line)
rclone copy out/target/product/$(grep unch $CIRRUS_WORKING_DIR/build_rom.sh -m 1 | cut -d ' ' -f 2 | cut -d _ -f 2 | cut -d - -f 1)/*.zip cirrus:$(grep unch $CIRRUS_WORKING_DIR/build_rom.sh -m 1 | cut -d ' ' -f 2 | cut -d _ -f 2 | cut -d - -f 1) -P
