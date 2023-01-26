repo init --depth=1 --no-repo-verify -u https://github.com/crdroidandroid/android.git -b 11.0 -g default,-mips,-darwin,-notdefault
git clone https://github.com/mountain47/local_manifest.git --depth 1 -b main .repo/local_manifests
repo sync

# build rom
. build/envsetup.sh
brunch sanders
export SELINUX_IGNORE_NEVERALLOWS=true
export ALLOW_MISSING_DEPENDENCIES=true
export RELAX_USES_LIBRARY_CHECK=true
export TZ=Asia/Dhaka 

# upload rom (if you don't need to upload multiple files, then you don't need to edit next line)
rclone copy out/target/product/$(grep unch $CIRRUS_WORKING_DIR/build_rom.sh -m 1 | cut -d ' ' -f 2 | cut -d _ -f 2 | cut -d - -f 1)/*.zip cirrus:$(grep unch $CIRRUS_WORKING_DIR/build_rom.sh -m 1 | cut -d ' ' -f 2 | cut -d _ -f 2 | cut -d - -f 1) -P
