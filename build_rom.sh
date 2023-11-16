# sync Rom    
repo init --depth=1 --no-repo-verify -u https://github.com/minimal-manifest-twrp/platform_manifest_twrp_aosp.git -b twrp-12.1 -g default,-mips,-darwin,-notdefault
git clone https://github.com/sheshuv/local_manifest.git --depth 1 -b twrp .repo/local_manifests
repo sync -c --no-clone-bundle --no-tags --optimized-fetch --prune --force-sync -j8
  
# build rom PixelOS fix kernel path fix safetynet fix branch
. build/envsetup.sh  
lunch twrp_sky-user 
export BUILD_USERNAME=Sheshu Vadrevu
export BUILD_HOSTNAME=sheshuv
export KBUILD_BUILD_USER=Sheshu Vadrevu   
export KBUILD_BUILD_HOST=sheshuv
export TZ=Asia/Delhi #put before last build command
m recoveryimage

# upload rom (if you don't need to upload multiple files, then you don't need to edit next line)
rclone copy out/target/product/recovery.img cirrus:$(grep unch recovery.img -P
