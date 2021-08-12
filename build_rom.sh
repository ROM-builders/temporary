# sync rom
repo init --depth=1 --no-repo-verify -u git://github.com/FlokoROM/manifesto.git -b 11.0 -g default,-device,-mips,-darwin,-notdefault
git clone https://github.com/LynzhX/local_manifest.git --depth 1 -b main .repo/local_manifests
repo sync -c --no-clone-bundle --no-tags --optimized-fetch --prune --force-sync -j8 || repo sync -j32 -c --no-clone-bundle --no-tags

# build rom
source build/envsetup.sh
lunch floko_RMX2001-userdebug
export TZ=Asia/Dhaka #put before last build command
export ALLOW_MISSING_DEPENDENCIES=true
mka bacon

# upload rom (if you don't need to upload multiple files, then you don't need to edit next line)

