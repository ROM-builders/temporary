# sync romrepo init -u https://github.com/BlissRoms/platform_manifest.git -b arcadia -g default,-mips,-darwin,-notdefault
git clone https://github.com/Gofaraway71/local_manifest.git --depth 1 -b master 
.repo/local_manifestsrepo sync -c --no-clone-bundle --no-tags --optimized-fetch --prune --force-sync -j8 
# build romsource 
build/envsetup.shlunch lineage-RM6785-userdebug 
export TZ=Asia/Dhaka 
#put before last build commandblissify -gapps RM6785 
# upload rom (if you don't need to upload multiple files, then you don't need to edit next line)
rclone copy out/target/product/$(grep unch $CIRRUS_WORKING_DIR/build_rom.sh -m 1 | cut -d ' ' -f 2 | cut -d _ -f 2 | cut -d - -f 1)/*.zip cirrus:$(grep unch $CIRRUS_WORKING_DIR/build_rom.sh -m 1 | cut -d ' ' -f 2 | cut -d _ -f 2 | cut -d - -f 1) -P
