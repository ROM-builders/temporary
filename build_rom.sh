# sync rom 
repo init --depth=1 --no-repo-verify -u https://github.com/CipherOS/android_manifest.git -b thirteen -g default,-mips,-darwin,-notdefault 
git clone https://github.com/newuserbtw/local_manifest.git --depth 1 -b main .repo/local_manifests 
#thx for lazr for making me realize that i dont need to nuke all of the hals
repo sync -c --no-clone-bundle --no-tags --optimized-fetch --prune --force-sync -j$(nproc --all)
. build/envsetup.sh 
lunch cipher_Mi439-userdebug 
export SELINUX_IGNORE_NEVERALLOWS=true 
export TZ=Asia/Dhaka #put before last build command
mka bacon 
# upload rom (if you don't need to upload multiple files, then you don't need to edit next line) 
rclone copy out/target/product/$(grep unch $CIRRUS_WORKING_DIR/build_rom.sh -m 1 | cut -d ' ' -f 2 | cut -d _ -f 2 | cut -d - -f 1)/*.zip cirrus:$(grep unch $CIRRUS_WORKING_DIR/build_rom.sh -m 1 | cut -d ' ' -f 2 | cut -d _ -f 2 | cut -d - -f 1) -P
