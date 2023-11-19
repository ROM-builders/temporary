# sync rom
repo init --depth=1 --no-repo-verify -u https://github.com/crdroidandroid/android.git -b 13.0 --git-lfs -g default,-mips,-darwin,-notdefault
git clone https://github.com/acex88/local_manifest.git --depth 1 -b crdroid .repo/local_manifests
repo sync -c --no-clone-bundle --no-tags --optimized-fetch --prune --force-sync -j8
    
# build rom  
. build/envsetup.sh 
lunch lineage_lancelot-userdebug    
export BUILD_USERNAME=raizel
export BUILD_HOSTNAME=acex88       
export TARGET_DISABLE_EPPE=true     
export KBUILD_BUILD_USER=raizel      
export KBUILD_BUILD_HOST=acex88 
export TZ=Asia/Delhi #put before last build command 
m bacon 
cat out/target/product/lancelot/lancelot.json
# upload rom (if you don't need to upload multiple files, then you don't need to edit next line)
rclone copy out/target/product/$(grep unch $CIRRUS_WORKING_DIR/build_rom.sh -m 1 | cut -d ' ' -f 2 | cut -d _ -f 2 | cut -d - -f 1)/*.zip cirrus:$(grep unch $CIRRUS_WORKING_DIR/build_rom.sh -m 1 | cut -d ' ' -f 2 | cut -d _ -f 2 | cut -d - -f 1) -P
