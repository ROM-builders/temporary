# sync rom
repo init --depth=1 --no-repo-verify -u git://github.com/LineageOS/manifest.git -b cm-14.1 -g default,-mips,-darwin,-notdefault
git clone https://github.com/m00nligh7/local_manifests_j1xlte-1.git --depth 1 -b master .repo/local_manifests
repo sync -c --no-clone-bundle --no-tags --optimized-fetch --prune --force-sync -j8

# build rom
source build/envsetup.sh
lunch lineage-j1xlte_eng
export TZ=Europe/Moscow #put before last build command
brunch lineage-j1xlte_eng

# upload rom (if you don't need to upload multiple files, then you don't need to edit next line)
rclone copy out/target/product/$(grep unch $CIRRUS_WORKING_DIR/build_rom.sh -m 1 | cut -d ' ' -f 2 | cut -d _ -f 2 | cut -d - -f 1)/*.zip cirrus:$(grep unch $CIRRUS_WORKING_DIR/build_rom.sh -m 1 | cut -d ' ' -f 2 | cut -d _ -f 2 | cut -d - -f 1) -P
