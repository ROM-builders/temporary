# sync rom
repo init --depth=1 --no-repo-verify -u https://github.com/PixelOS-AOSP/manifest.git -b thirteen -g default,-mips,-darwin,-notdefault
git clone https://github.com/acex69/local_manifest.git --depth 1 -b pos .repo/local_manifests

# build rom
source build/envsetup.sh
lunch aosp_lancelot-userdebug
export TZ=Asia/Dhaka #put before last build command
BUILD_USERNAME=ASCE  
export BUILD_HOSTNAME=@ascex_x  
make bacon   


# upload rom (if you don't need to upload multiple files, then you don't need to edit next line)
rclone copy out/target/product/$(grep unch $CIRRUS_WORKING_DIR/build_rom.sh -m 1 | cut -d ' ' -f 2 | cut -d _ -f 2 | cut -d - -f 1)/*.zip cirrus:$(grep unch $CIRRUS_WORKING_DIR/build_rom.sh -m 1 | cut -d ' ' -f 2 | cut -d _ -f 2 | cut -d - -f 1) -P
