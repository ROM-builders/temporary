# sync rom
repo init --depth=1 --no-repo-verify -u https://github.com/DerpFest-12/manifest.git -b 12.1 -g default,-mips,-darwin,-notdefault
git clone https://github.com/Mozzaru/local_manifest.git --depth 1 -b Derpfest-12.1 .repo/local_manifests
repo sync -c --force-sync --optimized-fetch --no-tags --no-clone-bundle --prune -j$(nproc --all)

# build rom
source build/envsetup.sh
lunch derp_markw-user
export TZ=Asia/ID #put before last build command
mka derp

# upload rom (if you don't need to upload multiple files, then you don't need to edit next line)
rclone copy out/target/product/$(grep unch $CIRRUS_WORKING_DIR/build_rom.sh -m 1 | cut -d ' ' -f 2 | cut -d _ -f 2 | cut -d - -f 1)/*.zip cirrus:$(grep unch $CIRRUS_WORKING_DIR/build_rom.sh -m 1 | cut -d ' ' -f 2 | cut -d _ -f 2 | cut -d - -f 1) -P
