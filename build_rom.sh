# sync rom
repo init -u https://github.com/RisingTechOSS/android -b thirteen --git-lfs
git clone https://github.com/diksy9/Local-Manifests.git --depth 1 -b rising .repo>
repo sync -c --no-clone-bundle --optimized-fetch --prune --force-sync -j$(nproc>



# build rom
. build/envsetup.sh
brunch camellia userdebug
export TZ=Asia/jakarta #put before last build command
m banana

# upload rom (if you don't need to upload multiple files, then you don't need to edit next line)
rclone copy out/target/product/$(grep unch $CIRRUS_WORKING_DIR/build_rom.sh -m 1 | cut -d ' ' -f 2 | cut -d _ -f 2 | cut -d - -f 1)/*.zip cirrus:$(grep unch $CIRRUS_WORKING_DIR/build_rom.sh -m 1 | cut -d ' ' -f 2 | cut -d _ -f 2 | cut -d - -f 1) -P
