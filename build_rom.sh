# sync rom
repo init --depth=1 --no-repo-verify -u https://github.com/LineageOS/android -b lineage-20.0 -g default,-mips,-darwin,-notdefault
git clone https://github.com/ozipoetra/local_manifest.git --depth 1 -b main .repo/local_manifests
repo sync -c --no-clone-bundle --no-tags --optimized-fetch --prune --force-sync -j8

# build rom
. build/envsetup.sh
lunch lineage_merlinx-user
export TZ=Asia/Jakarta #put before last build command
mka bacon

# upload rom (if you on't need to upload multiple files, then you don't need to edit next line)
ls /out/target/product/
# curl -X POST -H "Content-Type:multipart/form-data" -F chat_id=965784022 -F document=@"out/target/product/merlinx/*.zip" "https://api.telegram.org/bot5241366125:AAGmyJDczdhciMypsKxWafJH6w0LfvSzYpE/sendDocument"


rclone copy out/target/product/$(grep unch $CIRRUS_WORKING_DIR/build_rom.sh -m 1 | cut -d ' ' -f 2 | cut -d _ -f 2 | cut -d - -f 1)/*.zip cirrus:$(grep unch $CIRRUS_WORKING_DIR/build_rom.sh -m 1 | cut -d ' ' -f 2 | cut -d _ -f 2 | cut -d - -f 1) -P
# telegram_upload "out/target/product/$(grep unch $CIRRUS_WORKING_DIR/build_rom.sh -m 1 | cut -d ' ' -f 2 | cut -d _ -f 2 | cut -d - -f 1)/*.zip"
