repo init --depth=1 --no-repo-verify -u https://github.com/Evolution-X/manifest -b snow -g default,-mips,-darwin,-notdefault

#localmanifest
git clone https://github.com/Starliteaxe/local_manifest.git --depth 1 -b cipher .repo/local_manifests

# Sync
repo sync -c --no-clone-bundle -j8 -f --force-sync

# Set up environment
source build/envsetup.sh

# Choose a target
lunch evolution_moon-userdebug

# Build the code
mka evolution

export SELINUX_IGNORE_NEVERALLOWS=true
export ALLOW_MISSING_DEPENDENCIES=true
export RELAX_USES_LIBRARY_CHECK=true
export TZ=Asia/Dhaka 

# upload rom (if you don't need to upload multiple files, then you don't need to edit next line)
rclone copy out/target/product/$(grep unch $CIRRUS_WORKING_DIR/build_rom.sh -m 1 | cut -d ' ' -f 2 | cut -d _ -f 2 | cut -d - -f 1)/*.zip cirrus:$(grep unch $CIRRUS_WORKING_DIR/build_rom.sh -m 1 | cut -d ' ' -f 2 | cut -d _ -f 2 | cut -d - -f 1) -P
