# sync rom
repo init --depth=1 --no-repo-verify -u repo init -u https://git.stag-os.org/StagOS/manifest.git -b r11 -g default,-device,-mips,-darwin,-notdefault
git clone https://github.com/shashank1436/local_manifest.git --depth 1 -b main .repo/local_manifests
repo sync -c --no-clone-bundle --no-tags --optimized-fetch --prune --force-sync -j8

# build rom
source build/envsetup.sh
lunch stag_mido-userdebug
export TZ=Asia/Kolkata #put before last build command
mka stag
blissify -g -c mido

# upload rom (if you don't need to upload multiple files, then you don't need to edit next line)
rclone copy out/target/product/$(grep unch $CIRRUS_WORKING_DIR/build_rom.sh -m 1 | cut -d ' ' -f 2 | cut -d _ -f 2 | cut -d - -f 1)/*.zip cirrus:$(grep unch $CIRRUS_WORKING_DIR/build_rom.sh -m 1 | cut -d ' ' -f 2 | cut -d _ -f 2 | cut -d - -f 1) -P
