# sync rom
# repo init --depth=1 --no-repo-verify -u git://github.com/DerpFest-11/manifest.git -b 11 -g default,-mips,-darwin,-notdefault
repo init --depth=1 --no-repo-verify -u https://github.com/crdroidandroid/android.git -b 11.0  -g default,-mips,-darwin,-notdefault
# git clone https://github.com/pocox3pro/Local-Manifests.git --depth 1 -b master .repo/local_manifests
git clone https://github.com/SurvivalHorror/local_manifest.git --depth 1 -b main .repo/local_manifests
# repo sync --force-sync --current-branch --no-tags --no-clone-bundle --optimized-fetch --prune -j$(nproc --all)
repo sync -c --no-clone-bundle --no-tags  --optimized-fetch --force-sync --prune -j$(nproc --all)

# build rom
source build/envsetup.sh
breakfast cheryl
# export TZ=Asia/Dhaka #put before last build command
brunch cheryl

# upload rom (if you don't need to upload multiple files, then you don't need to edit next line)
rclone copy out/target/product/$(grep unch $CIRRUS_WORKING_DIR/build_rom.sh -m 1 | cut -d ' ' -f 2 | cut -d _ -f 2 | cut -d - -f 1)/*.zip cirrus:$(grep unch $CIRRUS_WORKING_DIR/build_rom.sh -m 1 | cut -d ' ' -f 2 | cut -d _ -f 2 | cut -d - -f 1) -P
