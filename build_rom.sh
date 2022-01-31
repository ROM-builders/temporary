# sync rom
repo init --depth=1 --no-repo-verify -u git://github.com/LineageOS/android.git -b lineage-18.1 default,-mips,-darwin,-notdefault
git clone https://github.com/mido/Local-Manifest2.git --depth 1 -b main .repo/local_manifests2
repo sync -c -f --force-sync --optimized-fetch --no-tags --no-clone-bundle --prune -j8

# build rom
source build/envsetup.sh
lunch derp_dld-user
export TZ=Asia/Dhaka #put before last build command
mka derp

# upload rom (if you don't need to upload multiple files, then you don't need to edit next line)
rclone copy out/target/product/$(grep unch $CIRRUS_WORKING_DIR/build_rom.sh -m 1 | cut -d ' ' -f 2 | cut -d _ -f 2 | cut -d - -f 1)/*.zip cirrus:$(grep unch $CIRRUS_WORKING_DIR/build_rom.sh -m 1 | cut -d ' ' -f 2 | cut -d _ -f 2 | cut -d - -f 1) -P
