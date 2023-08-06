# sync rom
repo init --depth=1 --no-repo-verify -u https://github.com/crdroidandroid/android.git -b 11.0 -g default,-mips,-darwin,-notdefault
git clone https://github.com/RyugaHideki14/local_manifest.git --depth 1 -b master .repo/local_manifests
repo sync -c --no-clone-bundle --no-tags --optimized-fetch --prune --force-sync -j8

# build rom
rm -rf hardware/qcom-caf/msm8998/audio
rm -rf hardware/qcom-caf/msm8998/display
rm -rf hardware/qcom-caf/msm8998/media
rm -rf hardware/qcom-caf/sm8250/audio
rm -rf hardware/qcom-caf/sm8250/display
rm -rf hardware/qcom-caf/sm8250/media
rm -rf packages/resources/devicesettings
rm -rf .repo/projects/hardware/qcom-caf/msm8998/audio.git
rm -rf .repo/projects/hardware/qcom-caf/msm8998/display.git
rm -rf .repo/projects/hardware/qcom-caf/msm8998/media.git
rm -rf .repo/projects/hardware/qcom-caf/sm8250/audio.git
rm -rf .repo/projects/hardware/qcom-caf/sm8250/display.git
rm -rf .repo/projects/hardware/qcom-caf/sm8250/media.git
rm -rf .repo/projects/packages/resources/devicesettings.git
source build/envsetup.sh
lunch lineage_lava-userdebug
export TZ=Asia/Dhaka #put before last build command
m bacon

# upload rom (if you don't need to upload multiple files, then you don't need to edit next line)
rclone copy out/target/product/$(grep unch $CIRRUS_WORKING_DIR/build_rom.sh -m 1 | cut -d ' ' -f 2 | cut -d _ -f 2 | cut -d - -f 1)/*.zip cirrus:$(grep unch $CIRRUS_WORKING_DIR/build_rom.sh -m 1 | cut -d ' ' -f 2 | cut -d _ -f 2 | cut -d - -f 1) -P
