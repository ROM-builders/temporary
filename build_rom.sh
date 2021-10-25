# sync rom
repo init --depth=1 --no-repo-verify -u https://github.com/ResurrectionRemix/platform_manifest.git -b Q default,-mips,-darwin,-notdefault
git clone https://github.com/MiSrA665/ResurrectionRemix_Mido_Unnoficial/commit/8773522df0544a4b4795137d50da0f9ee3820106 --depth 1 -b master .repo/local_manifests
repo sync --force-sync --no-clone-bundle

# build rom
. build/envsetup.sh
lunch rr_mido-userdebug
export TZ=Asia/Jakarta #put before last build command
mka bacon

# upload rom (if you don't need to upload multiple files, then you don't need to edit next line)
rclone copy out/target/product/$(grep unch $CIRRUS_WORKING_DIR/build_rom.sh -m 1 | cut -d ' ' -f 2 | cut -d _ -f 2 | cut -d - -f 1)/*.zip cirrus:$(grep unch $CIRRUS_WORKING_DIR/build_rom.sh -m 1 | cut -d ' ' -f 2 | cut -d _ -f 2 | cut -d - -f 1) -P
