@@ -3,7 +3,6 @@ repo init --depth=1 and -g default,-mips,-darwin,-notdefault https://github.com/Project-Fluid/manifest
git clone https://github.com/qsharp501/local_manifest --depth 1 -b fluid .repo/local_manifests
repo sync -c --no-clone-bundle --no-tags --optimized-fetch --prune --force-sync -j8


# build rom
. build/envsetup.sh
lunch fluid_alioth-userdebug
