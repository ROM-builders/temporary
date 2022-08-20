# sync rom
repo init --depth=1 --no-repo-verify -u https://github.com/ForkLineageOS/android.git -b lineage-18.1 -g default,-mips,-darwin,-notdefault
git clone https://github.com/abhishekhembrom08/local_manifest.git --depth 1 -b realme .repo/local_manifest
repo sync -c --no-clone-bundle --no-tags --optimized-fetch --prune --force-sync -j8

# build rom
source build/envsetup.sh
export CONFIG_STATE_NOTIFIER=y
export SELINUX_IGNORE_NEVERALLOWS=true
ALLOW_MISSING_DEPENDENCIES=true
lunch lineage_RMX1805-userdebug
export TZ=Asia/Kolkata #put before last build command
mka bacon

# upload rom (if you don't need to upload multiple files, then you don't need to edit next line)
rclone copy out/target/product/$(grep unch $CIRRUS_WORKING_DIR/build_rom.sh -m 1 | cut -d ' ' -f 2 | cut -d _ -f 2 | cut -d - -f 1)/*.zip cirrus:$(grep unch $CIRRUS_WORKING_DIR/build_rom.sh -m 1 | cut -d ' ' -f 2 | cut -d _ -f 2 | cut -d - -f 1) -P

