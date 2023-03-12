# sync rom
repo init --depth=1 --no-repo-verify -u https://github.com/DerpFest-AOSP/manifest -b 13 -g default,-mips,-darwin,-notdefault
git clone https://github.com/A51-Development/local_manifests --depth 1 .repo/local_manifests -b derp
repo sync -c --no-clone-bundle --no-tags --optimized-fetch --prune --force-sync -j8

# build r
source build/envsetup.sh
lunch derp_a51-user
export TZ=Asia/Seoul #put before last build command
mka bacon

# upload rom (if you don't need to upload multiple files, then you don't need to edit next line)
rclone copy out/target/product/$(grep unch $CIRRUS_WORKING_DIR/build_rom.sh -m 1 | cut -d ' ' -f 2 | cut -d _ -f 2 | cut -d - -f 1)/*.zip cirrus:$(grep unch $CIRRUS_WORKING_DIR/build_rom.sh -m 1 | cut -d ' ' -f 2 | cut -d _ -f 2 | cut -d - -f 1) -P
