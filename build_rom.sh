# sync rom
repo init --depth=1 --no-repo-verify -u https://github.com/ForkLineageOS/android.git -b lineage-18.1 -g default,-mips,-darwin,-notdefault
git clone https://github.com/wanderlusttt/local_manifest.git --depth 1 -b lineage-18.1 .repo/local_manifests
repo sync -c --no-clone-bundle --no-tags --optimized-fetch --prune --force-sync -j8

# build rom - Initial Build
source build/envsetup.sh
export TZ=Asia/Dhaka #put before last build command
export TARGET_FLOS=true
export LINEAGE_VERSION_APPEND_TIME_OF_DAY=true
export LINEAGE_BUILDTYPE=TEST
brunch X00TD

# upload rom (if you don't need to upload multiple files, then you don't need to edit next line)
rclone copy out/target/product/$(grep unch $CIRRUS_WORKING_DIR/build_rom.sh -m 1 | cut -d ' ' -f 2 | cut -d _ -f 2 | cut -d - -f 1)/*.zip cirrus:$(grep unch $CIRRUS_WORKING_DIR/build_rom.sh -m 1 | cut -d ' ' -f 2 | cut -d _ -f 2 | cut -d - -f 1) -P
