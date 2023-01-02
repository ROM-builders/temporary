# sync rom
repo init --depth=1 --no-repo-verify -u https://github.com/syberia-project/manifest.git -b 13.0 -g default,-mips,-darwin,-notdefault
git clone https://github.com/EmadGr8/local_manifest.git --depth 1 -b syberia .repo/local_manifests
repo sync -c --no-clone-bundle --no-tags --optimized-fetch --prune --force-sync -j8

# build rom
. build/envsetup.sh
lunch syberia_tulip-user
export TZ=Asia/Dhaka
mka syberia

# upload rom
rclone copy out/target/product/$(grep unch $CIRRUS_WORKING_DIR/build_rom.sh -m 1 | cut -d ' ' -f 2 | cut -d _ -f 2 | cut -d - -f 1)/*.zip cirrus:$(grep unch $CIRRUS_WORKING_DIR/build_rom.sh -m 1 | cut -d ' ' -f 2 | cut -d _ -f 2 | cut -d - -f 1) -P
