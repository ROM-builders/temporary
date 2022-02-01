
# sync rom
repo init --depth=1 --no-repo-verify -u https://github.com/Project-Crdroid/manifest.git -b 11.0 -g default,-mips,-darwin,-notdefault
git clone https://github.com/ashwani02c2/local_manifest.git --depth 1 -b main .repo/local_manifests
repo sync -c --no-clone-bundle --no-tags --optimized-fetch --prune --force-sync -j8

# build rom
. build/envsetup.sh
Brunch j7elte-user
export TZ=Asia/Dhaka
make Crdroid

# upload rom (if you don't need to upload multiple files, then you don't need to edit next line)
rclone copy out/target/product/$(grep unch $CIRRUS_WORKING_DIR/build_rom.sh -m 1 | cut -d ' ' -f 2 | cut -d _ -f 2 | cut -d - -f 1)/*.zip cirrus:$(grep unch $CIRRUS_WORKING_DIR/build_rom.sh -m 1 | cut -d ' ' -f 2 | cut -d _ -f 2 | cut -d - -f 1) -P























