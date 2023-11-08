# sync rom
repo init --depth=1 --no-repo-verify -u https://github.com/Havoc-OS/android_manifest.git -b thirteen -g default,-mips,-darwin,-notdefault
git clone https://github.com/YudhoPatrianto/local_manifests -b havoc .repo/local_manifests
repo sync -c --no-clone-bundle --no-tags --optimized-fetch --prune --force-sync -j8

# build rom

# Make Permissions append_certs.py
chmod 777 device/xiaomi/selene/dtbo/append_certs.py

. build/envsetup.sh
lunch lineage_selene-userdebug
export BUILD_USERNAME=YudhoPatrianto 
export BUILD_HOSTNAME=YudhoPRJKT
export KBUILD_BUILD_USER=$BUILD_USERNAME
export KBUILD_BUILD_HOST=$BUILD_HOSTNAME
export TZ=Asia/Dhaka #put before last build command
brunch selene

# upload rom (if you don't need to upload multiple files, then you don't need to edit next line)
rclone copy out/target/product/$(grep unch $CIRRUS_WORKING_DIR/build_rom.sh -m 1 | cut -d ' ' -f 2 | cut -d _ -f 2 | cut -d - -f 1)/*.zip cirrus:$(grep unch $CIRRUS_WORKING_DIR/build_rom.sh -m 1 | cut -d ' ' -f 2 | cut -d _ -f 2 | cut -d - -f 1) -P
