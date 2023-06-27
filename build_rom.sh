# sync Rom    
repo init --depth=1 --no-repo-verify -u https://github.com/PixelExperience/manifest.git -b thirteen-plus -g default,-mips,-darwin,-notdefault
git clone https://github.com/acex69/local_manifest.git --depth 1 -b merlinx .repo/local_manifests
repo sync -c --no-clone-bundle --no-tags --optimized-fetch --prune --force-sync -j8
# build rom             
source build/envsetup.sh 
lunch aosp_merlinx-userdebug   
export TZ=Asia/Delhi  
make bacon    
# upload rom (if you don't need to upload multiple files, then you don't need to edit next line) 
rclone copy out/target/product/$(grep unch $CIRRUS_WORKING_DIR/build_rom.sh -m 1 | cut -d ' ' -f 2 | cut -d _ -f 2 | cut
