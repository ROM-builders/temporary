# sync rom
repo init --depth=1 --no-repo-verify -u git://github.com/DerpFest-11/manifest.git -b 11 -g default,-device,-mips,-darwin,-notdefault
git clone https://github.com/pocox3pro/Local-Manifests.git --depth 1 -b master .repo/local_manifests
repo sync -c --no-clone-bundle --no-tags --optimized-fetch --prune --force-sync -j8

# build rom
source build/envsetup.sh
lunch derp_vayu-user
export TZ=Asia/Dhaka #put before last build command
mka derp

# upload rom (if you don't need to upload multiple files, then you don't need to edit next line)
if [ $(grep unch build_rom.sh -m 1 | cut -d ' ' -f 1) == "brunch" ]; then
device=$(grep unch build_rom.sh -m 1 | cut -d ' ' -f 2)
else
device=$(grep unch build_rom.sh -m 1 | cut -d ' ' -f 2 | cut -d _ -f 2,3 | cut -d - -f 1)
fi
rclone copy out/target/product/$device/*.zip cirrus:$device -P