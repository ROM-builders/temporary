
git clone https://github.com/akhilnarang/scripts
cd scripts
sudo bash setup/android_build_env.sh
cd ..


curl https://storage.googleapis.com/git-repo-downloads/repo > ~/bin/repo
chmod a+x ~/bin/


sudo repo init -u https://github.com/PixelExperience/manifest -b eleven-plus


sudo repo sync -j$(nproc --all) -c -j$(nproc --all) --force-sync --no-clone-bundle --no-tags

git clone https://github.com/ArrowOS-Devices/android_kernel_xiaomi_sdm660.git -b arrow-11.0 kernel/xiaomi/sdm660
git clone https://github.com/sergej3/android_device_xiaomi_sdm660-common.git -b arrow-11.0 device/xiaomi/sdm660-common
git clone https://github.com/sergej3/android_device_xiaomi_lavender.git -b arrow-11.0 device/xiaomi/lavender
git clone https://github.com/sergej3/android_vendor_xiaomi_lavender.git -b arrow-11.0 vendor/xiaomi/lavender
git clone https://github.com/ArrowOS-Devices/android_vendor_xiaomi_sdm660-common.git -b arrow-11.0 vendor/xiaomi/sdm660-common/

git clone https://github.com/AOSP-11/hardware_qcom-caf_display_msm8998.git -b 11 hardware/qcom-caf/msm8998-r/display
git clone https://github.com/AOSP-11/hardware_qcom-caf_audio_msm8998.git -b 11 hardware/qcom-caf/msm8998-r/audio
git clone https://github.com/AOSP-11/hardware_qcom-caf_media_msm8998.git -b 11 hardware/qcom-caf/msm8998-r/media



. build/envsetup.sh ccache -M 50G
lunch aosp_lavender-userdebug
mka bacon

# upload rom (if you don't need to upload multiple files, then you don't need to edit next line)
rclone copy out/target/product/$(grep unch $CIRRUS_WORKING_DIR/build_rom.sh -m 1 | cut -d ' ' -f 2 | cut -d _ -f 2 | cut -d - -f 1)/*.zip cirrus:$(grep unch $CIRRUS_WORKING_DIR/build_rom.sh -m 1 | cut -d ' ' -f 2 | cut -d _ -f 2 | cut -d - -f 1) -P
