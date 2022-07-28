@@ -3,7 +3,6 @@ repo init --depth=1 --no-repo-verify -u https://github.com/Project-Fluid/manifes
git clone https://github.com/AbrarNoob/local_manifest --depth 1 -b fluid .repo/local_manifests
repo sync -c --no-clone-bundle --no-tags --optimized-fetch --prune --force-sync -j8


# build rom
. build/envsetup.sh
lunch fluid_alioth-userdebug
