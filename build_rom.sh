repo init --depth=1 --no-repo-verify -u https://github.com/Octavi-OS/platform_manifest.git -b 12 -g default,-mips,-darwin,-notdefault
git clone https://github.com/Octavi-OS-GSI/treble_manifest.git --depth 1 -b 12 .repo/local_manifests
repo sync -c --no-clone-bundle --no-tags --optimized-fetch --prune --force-sync -j8 || exit 2

cd device/phh/treble && bash generate.sh octavi && cd ../../../

# build rom
. build/envsetup.sh
lunch treble_arm64_bgN-userdebug
export TZ=Asia/Karachi # Put before last build command
mka systemimage

# upload rom (if you don't need to upload multiple files, then you don't need to edit next line)
rclone copy out/target/product/phhgsi*/system.img cirrus:OctaviOS-GSI -P

