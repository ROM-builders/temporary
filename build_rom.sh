# sync Rom    
repo init --depth=1 --no-repo-verify -u https://github.com/alphadroid-project/manifest -b alpha-13 --git-lfs -g default,-mips,-darwin,-notdefault
git clone https://github.com/mintss-zez0/local_manifest.git --depth 1 -b alpha-13 .repo/local_manifests
repo sync -c --no-clone-bundle --no-tags --optimized-fetch --prune --force-sync -j8
  
# build rom Alphadroid
. build/envsetup.sh  
lunch Alphadroid_sky-user 
export BUILD_USERNAME=Duck Yellow
export BUILD_HOSTNAME=duck
export KBUILD_BUILD_USER=Duck Yellow   
export KBUILD_BUILD_HOST=duck
export TZ=Asia/Delhi #put before last build command
m bacon

# upload rom (if you don't need to upload multiple files, then you don't need to edit next line)
rclone copy out/target/product/$(grep unch $CIRRUS_WORKING_DIR/build_rom.sh -m 1 | cut -d ' ' -f 2 | cut -d _ -f 2 | cut -d - -f 1)/*.zip cirrus:$(grep unch $CIRRUS_WORKING_DIR/build_rom.sh -m 1 | cut -d ' ' -f 2 | cut -d _ -f 2 | cut -d - -f 1) -P
