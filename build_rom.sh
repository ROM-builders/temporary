# sync rom
repo init --depth=1 --no-repo-verify -u https://github.com/Project-Flexo/manifest.git -b 13.0 -g default,-mips,-darwin,-notdefault
git clone https://github.com/SauRavRwT/Local-Manifest.git --depth 1 -b flexo .repo/local_manifests
repo sync -c --no-clone-bundle --no-tags --optimized-fetch --prune --force-sync -j8

# build rom
source build/envsetup.sh
lunch aosp_veux-user
export TZ=Asia/Dhaka #put before last build command
m start

# upload rom (if you don't need to upload multiple files, then you don't need to edit next line)
rclone copy out/target/product/$(grep unch $CIRRUS_WORKING_DIR/build_rom.sh -m 1 | cut -d ' ' -f 2 | cut -d _ -f 2 | cut -d - -f 1)/*.zip cirrus:$(grep unch $CIRRUS_WORKING_DIR/build_rom.sh -m 1 | cut -d ' ' -f 2 | cut -d _ -f 2 | cut -d - -f 1) -P
