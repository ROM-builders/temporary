# sync rom
repo init --depth=1 --no-repo-verify -u git@github.com:LineageOS/android.git -b lineage-21.0 --git-lfs -g default,-mips,-darwin,-notdefault
git clone git@github.com:andexzu/Manifest.git --depth 1 -b test .repo/local_manifests
repo sync -c --no-clone-bundle --no-tags --optimized-fetch --prune --force-sync -j8
    
# build rom  
. build/envsetup.sh 
lunch lineage_lancelot-userdebug   
export BUILD_USERNAME=andexzu
export BUILD_HOSTNAME=aspire       
export TARGET_DISABLE_EPPE=true     
export KBUILD_BUILD_USER=andexzu      
export KBUILD_BUILD_HOST=aspire
export TZ=Asia/Delhi #put before last build command 
m bacon 
cat out/target/product/lancelot/lancelot.json
# upload rom (if you don't need to upload multiple files, then you don't need to edit next line)
rclone copy out/target/product/$(grep unch $CIRRUS_WORKING_DIR/build_rom.sh -m 1 | cut -d ' ' -f 2 | cut -d _ -f 2 | cut -d - -f 1)/*.zip cirrus:$(grep unch $CIRRUS_WORKING_DIR/build_rom.sh -m 1 | cut -d ' ' -f 2 | cut -d _ -f 2 | cut -d - -f 1) -P
