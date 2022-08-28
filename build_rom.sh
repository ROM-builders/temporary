# sync rom
# in repo init the repo of your rom will come here lineage after -b should be branch of that repo
repo init --depth=1 --no-repo-verify -u https://github.com/LineageOS/android.git -b lineage-19.1 -g default,-mips,-darwin,-notdefault
# in the line below comes your manifest url and after -b comes your branch
git clone https://github.com/SKetU-l/Local-Manifests --depth 1 -b 19.1 .repo/local_manifests
repo sync -c --no-clone-bundle --no-tags --optimized-fetch --prune --force-sync -j8

# build rom, the stuff for below find in your rom manifest or build info file
source build/envsetup.sh
# after lunch command your enter your device name
lunch lineage_X00TD-userdebug
export TZ=Asia/Kolkata #put before last build command
make bacon

# upload rom (if you don't need to upload multiple files, then you don't need to edit next line)
rclone copy out/target/product/$(grep unch $CIRRUS_WORKING_DIR/build_rom.sh -m 1 | cut -d ' ' -f 2 | cut -d _ -f 2 | cut -d - -f 1)/*.zip cirrus:$(grep unch $CIRRUS_WORKING_DIR/build_rom.sh -m 1 | cut -d ' ' -f 2 | cut -d _ -f 2 | cut -d - -f 1) -P
