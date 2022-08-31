# sync rom
repo init --depth=1 --no-repo-verify -u https://github.com/LineageOS/android.git -b lineage-18.1 -g default,-mips,-darwin,-notdefault
git clone https://github.com/exynos7580-dev/local_manifests --depth 1 -b main .repo/local_manifests
repo sync -c --no-clone-bundle --no-tags --optimized-fetch --prune --force-sync -j8

# build rom
source build/envsetup.sh
breakfast j7elte
export TZ=Europe/Istanbul #put before last build command
croot
brunch j7elte

# upload rom (if you don't need to upload multiple files, then you don't need to edit next line)
sha256sum out/target/product/j7elte/*
git clone https://github.com/exynos7580-dev/lineage_OTA.git
bash lineage_OTA/scripts/recovery-j7elte.sh
rclone copy out/target/product/$(grep unch $CIRRUS_WORKING_DIR/build_rom.sh -m 1 | cut -d ' ' -f 2 | cut -d _ -f 2 | cut -d - -f 1)/*.zip cirrus:$(grep unch $CIRRUS_WORKING_DIR/build_rom.sh -m 1 | cut -d ' ' -f 2 | cut -d _ -f 2 | cut -d - -f 1) -P
