# sync rom
repo init --depth=1 --no-repo-verify -u https://github.com/Evolution-X/manifest -b snow -g default,-mips,-darwin,-notdefault
git clone https://github.com/r9lab/local_manifest.git --depth 1 -b evo .repo/local_manifests
repo sync -c --no-clone-bundle --no-tags --optimized-fetch --prune --force-sync -j8

# patch ims
rm -rf frameworks/opt/telephony 
git clone https://github.com/CipherOS/android_frameworks_opt_telephony -b twelve-L frameworks/opt/telephony 
rm -rf packages/modules/Wifi
git clone https://github.com/CipherOS/android_packages_modules_Wifi -b twelve-L packages/modules/Wifi
rm -rf frameworks/opt/net/ims
git clone https://github.com/CipherOS/android_frameworks_opt_net_ims -b twelve-L frameworks/opt/net/ims

# build rom
source build/envsetup.sh
lunch evolution_lava-userdebug
export SELINUX_IGNORE_NEVERALLOWS=true
export TZ=Asia/Dhaka #put before last build command
mka evolution

# upload rom (if you don't need to upload multiple files, then you don't need to edit next line)
rclone copy out/target/product/$(grep unch $CIRRUS_WORKING_DIR/build_rom.sh -m 1 | cut -d ' ' -f 2 | cut -d _ -f 2 | cut -d - -f 1)/*.zip cirrus:$(grep unch $CIRRUS_WORKING_DIR/build_rom.sh -m 1 | cut -d ' ' -f 2 | cut -d _ -f 2 | cut -d - -f 1) -P
