repo init --depth=1 --no-repo-verify -u git://https://github.com/Miku-UI/manifesto.git -b TDA -g default,-mips,-darwin,-notdefault
git clone https://github.com/dandelion64-Archives/local_manifests.git --depth 1 -b lineage-20 .repo/local_manifests
repo sync -c --no-clone-bundle --no-tags --optimized-fetch --prune --force-sync -j8

# build rom
source build/envsetup.sh
lunch lineage_blossom-userdebug
export TZ=Asia/Dhaka #put before last build command
make diva
