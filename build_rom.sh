# sync rom
repo init --depth=1 --no-repo-verify -u https://github.com/P-404/android_manifest -b tokui -g default,-mips,-darwin,-notdefault
git clone https://github.com/p404-vayu/local_manifest --depth=1 -b tokui .repo/local_manifests
repo sync -c --no-clone-bundle --no-tags --optimized-fetch --prune --force-sync -j8
     
# build rom
source build/envsetup.sh
lunch p404_vayu-user
export WITH_GAPPS=true
export TZ=Asia/Kolkata #put before last build command
make bacon
                                                 
# upload rom (if you don't need to upload multiple files, then you don't need to edit next line)
rclone copy out/target/product/$(grep unch $CIRRUS_WORKING_DIR/build_rom.sh -m 1 | cut -d ' ' -f 2 | cut -d _ -f 2 | cut -d - -f 1)/*.zip cirrus:$(grep unch $CIRRUS_WORKING_DIR/build_rom.sh -m 1 | cut -d ' ' -f 2 | cut -d _ -f 2 | cut -d - -f 1) -P
 
  
 
