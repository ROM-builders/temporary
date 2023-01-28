repo init --depth=1 --no-repo-verify -u https://github.com/PixelPlusUI-SnowCone/manifest -b snowcone-12.1 -g default,-mips,-darwin,-notdefault

#localmanifest
git clone https://github.com/mountain47/local_manifest-starliteaxe.git --depth 1 -b cipher .repo/local_manifests

# Sync
repo sync -c -j8 --force-sync --no-clone-bundle --no-tags

# Set up environment
source build/envsetup.sh
# Choose a target
lunch aosp_$moon-userdebug
# Build the code
mka bacon -j8

export SELINUX_IGNORE_NEVERALLOWS=true
export ALLOW_MISSING_DEPENDENCIES=true
export RELAX_USES_LIBRARY_CHECK=true
export TZ=Asia/Dhaka 

# upload rom (if you don't need to upload multiple files, then you don't need to edit next line)
rclone copy out/target/product/$(grep unch $CIRRUS_WORKING_DIR/build_rom.sh -m 1 | cut -d ' ' -f 2 | cut -d _ -f 2 | cut -d - -f 1)/*.zip cirrus:$(grep unch $CIRRUS_WORKING_DIR/build_rom.sh -m 1 | cut -d ' ' -f 2 | cut -d _ -f 2 | cut -d - -f 1) -P
