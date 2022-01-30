# sync rom
repo init --depth=1 --no-repo-verify -u https://github.com/Evolution-X/manifest.git -b snow -g default,-mips,-darwin,-notdefault
git clone https://github.com/Sushrut1101-ROMs/Local-Manifests.git --depth 1 -b m20lte .repo/local_manifests
repo sync -c --no-clone-bundle --no-tags --optimized-fetch --prune --force-sync -j8

# build rom
source build/envsetup.sh
lunch evolution_m20lte-userdebug
export TZ=Asia/Kolkata #put before last build command
export ALLOW_MISSING_DEPENDENCIES=true #  Sorry to use, but it is a workaroud to fix errors related to lineage dependencies that isn't needed for AOSP.
export SKIP_ABI_CHECKS=true
export JVAL="-j24"
export TARGET=evolution
mka ${JVAL} ${TARGET}

# upload rom (if you don't need to upload multiple files, then you don't need to edit next line)
rclone copy out/target/product/$(grep unch $CIRRUS_WORKING_DIR/build_rom.sh -m 1 | cut -d ' ' -f 2 | cut -d _ -f 2 | cut -d - -f 1)/*.zip cirrus:$(grep unch $CIRRUS_WORKING_DIR/build_rom.sh -m 1 | cut -d ' ' -f 2 | cut -d _ -f 2 | cut -d - -f 1) -P
