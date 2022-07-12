# sync rom
repo init -u https://github.com/Evolution-X/manifest -b snow -g default,-mips,-darwin,-notdefault
git clone https://github.com/Pranav-Talmale/local_manifest_raphael_voidui.git --depth 1 -b EvoX .repo/local_manifests
repo sync -c -j$(nproc --all) --force-sync --no-clone-bundle --no-tags
# build rom
. build/envsetup.sh
lunch evolution_raphael-eng
export TZ=Asia/Kolkata #put before last build command
mka evolution

# upload rom (if you don't need to upload multiple files, then you don't need to edit next line)
rclone copy out/target/product/$(grep unch $CIRRUS_WORKING_DIR/build_rom.sh -m 1 | cut -d ' ' -f 2 | cut -d _ -f 2 | cut -d - -f 1)/*.zip cirrus:$(grep unch $CIRRUS_WORKING_DIR/build_rom.sh -m 1 | cut -d ' ' -f 2 | cut -d _ -f 2 | cut -d - -f 1) -P
