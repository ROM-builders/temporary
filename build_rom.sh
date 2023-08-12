# sync rom
repo init --depth=1 --no-repo-verify -u https://github.com/RisingTechOSS/android -b thirteen -g default,-mips,-darwin,-notdefault
git clone https://github.com/acex69/local_manifest --depth 1 -b rising .repo/local_manifests
repo sync -c --no-clone-bundle --no-tags --optimized-fetch --prune --force-sync -j8

# build rom
source build/envsetup.sh
lunch lineage_lancelot-userdebug
export WITH_GMS=true
export TARGET_CORE_GMS := true
export TARGET_USE_GOOGLE_TELEPHONY := true
export TZ=Asia/Mumbai #put before last build command 
export BUILD_USERNAME=Di Raizel  
export BUILD_HOSTNAME=@acex88    
make bacon 

# upload rom (if your don't need to upload multiple files, then you don't need to edit next line)
rclone copy out/target/product/$(grep unch $CIRRUS_WORKING_DIR/build_rom.sh -m 1 | cut -d ' ' -f 2 | cut -d _ -f 2 | cut -d - -f 1)/*.zip cirrus:$(grep unch $CIRRUS_WORKING_DIR/build_rom.sh -m 1 | cut -d ' ' -f 2 | cut -d _ -f 2 | cut -d - -f 1) -P
