# sync rom
repo init --depth=1 --no-repo-verify -u git://github.com/ProjectRadiant/manifest -b eleven -g default,-device,-mips,-darwin,-notdefault
wget -S https://raw.githubusercontent.com/lazydev1852/LGV30Dot5.2/main/joan_build.xml -O .repo/local_manifests/joan_build.xml
repo sync -c --no-clone-bundle --no-tags --optimized-fetch --prune --force-sync -j8

# build rom
source build/envsetup.sh
lunch radiant_joan-userdebug
export TZ=Europe/Moscow #put before last build command
make bacon

# upload rom (if you don't need to upload multiple files, then you don't need to edit next line)
rclone copy out/target/product/$(grep unch $CIRRUS_WORKING_DIR/build_rom.sh -m 1 | cut -d ' ' -f 2 | cut -d _ -f 2 | cut -d - -f 1)/*.zip cirrus:$(grep unch $CIRRUS_WORKING_DIR/build_rom.sh -m 1 | cut -d ' ' -f 2 | cut -d _ -f 2 | cut -d - -f 1) -P
