# sync Rom    
repo init --depth=1 --no-repo-verify -u https://github.com/PixelOS-AOSP/manifest.git -b thirteen -g default,-mips,-darwin,-notdefault
git clone https://github.com/sheshuv/local_manifest.git --depth 1 -b main .repo/local_manifests
repo sync -c --no-clone-bundle --no-tags --optimized-fetch --prune --force-sync -j8
  
# build rom PixelOs
. build/envsetup.sh  
lunch aosp_sky-user 
export BUILD_USERNAME=Sheshu Vadrevu
export BUILD_HOSTNAME=sheshuv
export KBUILD_BUILD_USER=Sheshu Vadrevu   
export KBUILD_BUILD_HOST=sheshuv
export TZ=Asia/Delhi #put before last build command
m bacon

# upload rom (if you don't need to upload multiple files, then you don't need to edit next line)
rclone copy out/target/product/$(grep unch $CIRRUS_WORKING_DIR/build_rom.sh -m 1 | cut -d ' ' -f 2 | cut -d _ -f 2 | cut -d - -f 1)/*.zip cirrus:$(grep unch $CIRRUS_WORKING_DIR/build_rom.sh -m 1 | cut -d ' ' -f 2 | cut -d _ -f 2 | cut -d - -f 1) -P
