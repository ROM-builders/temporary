# sync rom
repo init --depth=1 --no-repo-verify -u https://github.com/crdroidandroid/android.git -b 13.0 -g default,-mips,-darwin,-notdefault
git clone https://github.com/NOTURFRIENDBTW/local_manifests --depth 1 -b ysl .repo/local_manifests
repo sync -c --no-clone-bundle --no-tags --optimized-fetch --prune --force-sync -j8

# build rom
source build/envsetup.sh 
 lunch crdroid_ysl-userdebug 
 export KBUILD_BUILD_USER=skhife  
 export KBUILD_BUILD_HOST=skhifekzk  
 export BUILD_USERNAME=skhife 
 export BUILD_HOSTNAME=skhifekzk 
 export BUILD_BROKEN_MISSING_REQUIRED_MODULES=true 
 export TZ=Asia/Dhaka #put before last build command 
 mka crdroidandroid

# upload rom (if you don't need to upload multiple files, then you don't need to edit next line)
rclone copy out/target/product/$(grep unch $CIRRUS_WORKING_DIR/build_rom.sh -m 1 | cut -d ' ' -f 2 | cut -d _ -f 2 | cut -d - -f 1)/*.zip cirrus:$(grep unch $CIRRUS_WORKING_DIR/build_rom.sh -m 1 | cut -d ' ' -f 2 | cut -d _ -f 2 | cut -d - -f 1) -P
