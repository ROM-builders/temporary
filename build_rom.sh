# sync rom
repo init --depth=1 --no-repo-verify -u https://github.com/Evolution-X/manifest -b tiramisu -g default,-mips,-darwin,-notdefault
git clone https://github.com/weaponmasterjax/local_manifest.git --depth 1 -b spark-13 .repo/local_manifests
rm -rf .repo/projects/hardware/qcom-caf/sm8250/audio.git hardware/qcom-caf/sm8250/audio
rm -rf .repo/projects/hardware/qcom-caf/sm8250/display.git hardware/qcom-caf/sm8250/display
rm -rf .repo/projects/hardware/qcom-caf/sm8250/media.git hardware/qcom-caf/sm8250/media
repo sync -c --no-clone-bundle --no-tags --optimized-fetch --prune --force-sync -j8

# build rom
source build/envsetup.sh
lunch evolution_everpal-eng
export TZ=Asia/Dhaka #put before last build command
export WITH_GAPPS=true
mka evolution

# upload rom (if you don't need to upload multiple files, then you don't need to edit next line)
rclone copy out/target/product/$(grep unch $CIRRUS_WORKING_DIR/build_rom.sh -m 1 | cut -d ' ' -f 2 | cut -d _ -f 2 | cut -d - -f 1)/*.zip cirrus:$(grep unch $CIRRUS_WORKING_DIR/build_rom.sh -m 1 | cut -d ' ' -f 2 | cut -d _ -f 2 | cut -d - -f 1) -P
