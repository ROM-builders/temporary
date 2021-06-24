# sync rom
repo init -u https://github.com/SpiceOS/android.git -b 11 --depth=1 -g default,-device,-mips,-darwin,-notdefault
git clone https://github.com/Dreadwyrm/local_manifests --depth=1 -b main .repo/local_manifests
repo sync -c -j$(nproc --all) --force-sync --no-clone-bundle --no-tags

# build rom
. build/envsetup.sh
breakfast ginkgo
export TZ=Asia/Jakarta
mka nad

# upload rom (if you don't need to upload multiple files, then you don't need to edit next line)
rclone copy out/target/product/$(grep unch $CIRRUS_WORKING_DIR/build_rom.sh -m 1 | cut -d ' ' -f 2 | cut -d _ -f 2 | cut -d - -f 1)/*.zip cirrus:$(grep unch $CIRRUS_WORKING_DIR/build_rom.sh -m 1 | cut -d ' ' -f 2 | cut -d _ -f 2 | cut -d - -f 1) -P
