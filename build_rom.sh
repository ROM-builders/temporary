# sync rom
repo init --depth=1 --no-repo-verify -u https://github.com/PixelExperience/manifest.git -b twelve -g default,-mips,-darwin,-notdefault
git clone https://github.com/MadmoudRMX2020/local_manifest.git --depth 1 -b main .repo/local_manifests
repo sync -c --no-clone-bundle --no-tags --optimized-fetch --prune --force-sync -j8
cd frameworks/base
wget https://raw.githubusercontent.com/sarthakroy2002/random-stuff/main/Patches/Fix-brightness-slider-curve-for-some-devices-a12l.patch && patch -p1 < *.patch
cd -
cd system/core
git fetch https://review.arrowos.net/ArrowOS/android_system_core refs/changes/00/16200/1
git cherry-pick FETCH_HEAD
cd ../..
cd frameworks/opt/net/ims
git fetch https://github.com/AOSP-12-RMX2020/frameworks_opt_net_ims
git cherry-pick 4f35ccb8bf0362c31bf5f074bcb7070da660412a^..3fe1cb7b6b2673adfce2b9232dfaf81375398efb
cd ../../../..
cd packages/modules/Wifi
git fetch https://github.com/AOSP-12-RMX2020/packages_modules_Wifi
git cherry-pick c6e404695bc451a9667f4893501ef8fe78e1a0b7^..90fc3f6781171dc27fed16b60575f9ea62f02e7a
cd ../../..
cd frameworks/opt/telephony
git fetch https://github.com/phhusson/platform_frameworks_opt_telephony android-12.0.0_r26-phh
git cherry-pick 6f116d4cdb716072261ecfe532da527182f6dad6
cd ../../..
cd system/security
git fetch https://github.com/AOSP-12-RMX2020/android_system_security
git cherry-pick d2bf978444da8d80a71b34c37f1c1853a405935c
cd ../..

# build rom
source build/envsetup.sh
lunch aosp_$RMX2020-eng
export TZ=Asia/Dhaka #put before last build command
mka bacon


# upload rom (if you don't need to upload multiple files, then you don't need to edit next line)
rclone copy out/target/product/$(grep unch $CIRRUS_WORKING_DIR/build_rom.sh -m 1 | cut -d ' ' -f 2 | cut -d _ -f 2 | cut -d - -f 1)/*.zip cirrus:$(grep unch $CIRRUS_WORKING_DIR/build_rom.sh -m 1 | cut -d ' ' -f 2 | cut -d _ -f 2 | cut -d - -f 1) -P
