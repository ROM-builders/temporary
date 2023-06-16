# sync rom
repo init --depth=1 --no-repo-verify -u https://github.com/crdroidandroid/android.git -b 11.0 --git-lfs -g default,-mips,-darwin,-notdefault
git clone https:https://github.com/mitsu00/local_manifest.git --depth 1 -b crdroid-11 .repo/local_manifests
repo sync -c --no-clone-bundle --no-tags --optimized-fetch --prune --force-sync -j8

# build rom
. build/envsetup.sh
lunch lineage_merlinx-user
export ALLOW_MISSING_DEPENDENCIES=true
export BUILD_USERNAME=mitsu00
export BUILD_HOSTNAME=ozip
export TZ=Asia/Jakarta #putt before last build command
mka bacon

# upload rom (if you don't need to upload multiple files, then you don't need to edit next line)
rclone copy out/target/product/$(grep unch $CIRRUS_WORKING_DIR/build_rom.sh -m 1 | cut -d ' ' -f 2 | cut -d _ -f 2 | cut -d - -f 1)/*.zip cirrus:$(grep unch $CIRRUS_WORKING_DIR/build_rom.sh -m 1 | cut -d ' ' -f 2 | cut -d _ -f 2 | cut -d - -f 1) -P
