repo init --depth=1 --no-repo-verify -u git://https://github.com/Miku-UI/manifesto.git -b TDA -g default,-mips,-darwin,-notdefault
git clone https://github.com/nosebs/local_manifest.git --depth 1 -b main .repo/local_manifests
repo sync -c --no-clone-bundle --no-tags --optimized-fetch --prune --force-sync -j8

# build rom
source build/envsetup.sh
lunch lineage_blossom-userdebug
export TZ=Asia/Dhaka #put before last build command
make diva

rclone copy out/target/product/$(grep unch $CIRRUS_WORKING_DIR/build_rom.sh -m 1 | cut -d ' ' -f 2 | cut -d _ -f 2 | cut -d - -f 1)/*.zip cirrus:$(grep unch $CIRRUS_WORKING_DIR/build_rom.sh -m 1 | cut -d ' ' -f 2 | cut -d _ -f 2 | cut -d - -f 1) -P
