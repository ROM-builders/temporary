# sync rom
repo init --depth=1 --no-repo-verify -u https://github.com/ProjectRadiant/manifest -b eleven -g default,-mips,-darwin,-notdefault
repo sync -c --no-clone-bundle --no-tags --optimized-fetch --prune --force-sync -j8

# remove hal
rm -rf hardware/qcom-caf/msm8996/display &&  rm -rf hardware/qcom-caf/msm8996/audio && rm -rf hardware/qcom-caf/msm8996/media

# clone manifest
git clone https://github.com/Hunter-commits/local_manifest.git --depth 1 -b main .repo/local_manifests
repo sync -m local_manifest.xml

# build rom
source build/envsetup.sh
lunch radiant_mido-user
export TZ=Asia/Dhaka #put before last build command
mka bacon

# upload rom (if you don't need to upload multiple files, then you don't need to edit next line)
rclone copy out/target/product/$(grep unch $CIRRUS_WORKING_DIR/build_rom.sh -m 1 | cut -d ' ' -f 2 | cut -d _ -f 2 | cut -d - -f 1)/*.zip cirrus:$(grep unch $CIRRUS_WORKING_DIR/build_rom.sh -m 1 | cut -d ' ' -f 2 | cut -d _ -f 2 | cut -d - -f 1) -P
