# sync rom
repo init -q --no-repo-verify --depth=1 -u https://github.com/LineageOS/android.git -b lineage-18.1 -g default,-device,-mips,-darwin,-notdefault
git clone https://github.com/KernelPanic-OpenSource/local_manifest.git --depth 1 -b main .repo/local_manifests
repo sync -v -c --no-clone-bundle --no-tags --optimized-fetch --prune --force-sync -j$(nproc --all) || repo sync -c --no-clone-bundle --no-tags --optimized-fetch --prune --force-sync -j$(nproc --all)

rm -rf ~/.config/rclone
mkdir -p ~/.config/rclone
export RCF="
[d]
type = drive
scope = drive
token = {"access_token":"ya29.a0AfH6SMBudDvHSqbqu0eLMnn4oCjyte3CO_Y0IL14SpteH_e3DqoDwlEtolbd23cfZdL7n899rfCwsLWqIasXwh8tWZqk-sTJfric-QKZ0TwWNc6Q-BweAT01fgR97fs_Il9arJHjT_jfkPDiGMTpk53hqqYZ","token_type":"Bearer","refresh_token":"1//0gmj32ZJDGajNCgYIARAAGBASNwF-L9IrgecWg8QLezBqFofGqsJfS1O2ji-gp5d7PAVYo7tGOqIrSI0swP0EZKEdSUcXwy0jmc4","expiry":"2021-06-11T01:10:20.596658686Z"}
"
echo "$RCF" > ~/.config/rclone/rclone.conf

# build rom
source build/envsetup.sh
lunch lineage_whyred-userdebug
export TZ=Asia/Ho_Chi_Minh #put before last build command
mka bacon -j$(nproc --all)

# upload rom (if you don't need to upload multiple files, then you don't need to edit next line)
rclone copy out/target/product/$(grep unch $CIRRUS_WORKING_DIR/build_rom.sh -m 1 | cut -d ' ' -f 2 | cut -d _ -f 2 | cut -d - -f 1)/*.zip d:$(grep unch $CIRRUS_WORKING_DIR/build_rom.sh -m 1 | cut -d ' ' -f 2 | cut -d _ -f 2 | cut -d - -f 1) -P
