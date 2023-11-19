 # sync rom
repo init --depth=1 --no-repo-verify -u https://github.com/crdroidandroid/android.git -b 12.1 --git-lfs -g default,-mips,-darwin,-notdefault
git clone https://github.com/Assunzain/local_manifest.git -b crdroid .repo/local_manifests
repo sync -c --no-clone-bundle --no-tags --optimized-fetch --prune --force-sync -j8
    
# build rom  
. build/envsetup.sh 
lunch lineage_X01AD-userdebug    
export BUILD_USERNAME=Assunzain
export BUILD_HOSTNAME=Zain
export ALLOW_MISSING_DEPENDENCIES=true
export KBUILD_BUILD_USER=Assunzain      
export KBUILD_BUILD_HOST=Assunzain 
export TZ=Asia/Jakarta #put before last build command 
m bacon -j8

# upload rom (if you don't need to upload multiple files, then you don't need to edit next line)
rclone copy out/target/product/$(grep unch $CIRRUS_WORKING_DIR/build_rom.sh -m 1 | cut -d ' ' -f 2 | cut -d _ -f 2 | cut -d - -f 1)/*.zip cirrus:$(grep unch $CIRRUS_WORKING_DIR/build_rom.sh -m 1 | cut -d ' ' -f 2 | cut -d _ -f 2 | cut -d - -f 1) -P
