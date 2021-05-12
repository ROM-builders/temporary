# sync rom
repo init -u https://github.com/Ancient-Lab/manifest -b ten && repo sync -c -j$(nproc --all) --force-sync --no-clone-bundle --no-tags && git clone https://github.com/smokey18/device_xiaomi_mido -b ten device/xiaomi/mido && git clone https://github.com/smokey18/vendor_xiaomi_mido -b ten vendor/xiaomi && git clone https://github.com/Scarlett-Project/kernel_xiaomi_msm8953-4.9 -b lineage-17.1 kernel/xiaomi/mido && rm -rf hardware/qcom-caf/msm8996/display && git clone https://github.com/smokey18/hardware_qcom_display -b ten-caf-msm8996 hardware/qcom-caf/msm8996/display && rm -rf hardware/qcom-caf/msm8996/media && git clone https://github.com/smokey18/hardware_qcom_media -b ten-caf-msm8996 hardware/qcom-caf/msm8996/media && rm -rf hardware/qcom-caf/msm8996/audio && git clone https://github.com/smokey18/hardware_qcom_audio -b ten-caf-msm8996 hardware/qcom-caf/msm8996/audio && git clone https://github.com/kdrag0n/proton-clang prebuilts/clang/host/linux-x86/clang-proton

# build rom
. build/envsetup.sh
lunch ancient_<devicecodename>-userdebug
mka bacon -j$(nproc --all)

# upload rom
device=$(grep unch $CIRRUS_WORKING_DIR/build_rom.sh -m 1 | cut -d _ -f 2 | cut -d - -f 1)
rclone copy out/target/product/mido/Ancient*.zip cirrus:$device -P
