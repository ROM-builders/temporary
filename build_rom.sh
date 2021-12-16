# sync rom

repo init --depth=1 --no-repo-verify -u https://github.com/PixelExtended/manifest -b 12 -g default,-mips,-darwin,-notdefault

git clone https://github.com/bdbdcom/local_manifest.git --depth 1 -b backup .repo/local_manifests

repo sync -c --no-clone-bundle --no-tags --optimized-fetch --prune --force-sync -j8

# build rom

source build/envsetup.sh

lunch aosp_mido-userdebug

export SKIP_ABI_CHECKS=true

export ALLOW_MISSING_DEPENDENCIES=true

export SELINUX_IGNORE_NEVERALLOWS=true

export TZ=Asia/Jakarta #put before last build command

make bacon

# upload rom (if you don't need to upload multiple files, then you don't need to edit next line)

rclone copy out/target/product/$(grep unch $CIRRUS_WORKING_DIR/build_rom.sh -m 1 | cut -d ' ' -f 2 | cut -d _ -f 2 | cut -d - -f 1)/*.zip cirrus:$(grep unch $CIRRUS_WORKING_DIR/build_rom.sh -m 1 | cut -d ' ' -f 2 | cut -d _ -f 2 | cut -d - -f 1) -P
