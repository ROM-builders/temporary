#bin
mkdir -p ~/bin
mkdir -p ~/havoc

# sync rom
repo init -u https://github.com/Havoc-OS/android_manifest.git -b twelve
git clone https://github.com/NRanjan-17/local_manifest.git --depth 1 -b main .repo/local_manifests
repo sync -c -j$(nproc --all) --force-sync --no-clone-bundle --no-tags

# build rom
source build/envsetup.sh
lunch havoc_mido-userdebug
export SKIP_ABI_CHECKS=true
export TZ=Asia/Delhi #put before last build command
brunch


# upload rom (if you don't need to upload multiple files, then you don't need to edit next line)
rclone copy out/target/product/$(grep unch $CIRRUS_WORKING_DIR/build_rom.sh -m 1 | cut -d ' ' -f 2 | cut -d _ -f 2 | cut -d - -f 1)/*.zip cirrus:$(grep unch $CIRRUS_WORKING_DIR/build_rom.sh -m 1 | cut -d ' ' -f 2 | cut -d _ -f 2 | cut -d - -f 1) -P
