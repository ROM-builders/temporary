# sync rom
repo init --depth=1 --no-repo-verify -u https://github.com/Evolution-X/manifest -b tiramisu -g default,-mips,-darwin,-notdefault
git clone https://github.com/Lenovo-SM6225-Fork/local_manifests --depth 1 .repo/local_manifests -b evox-13
repo sync -c --no-clone-bundle --no-tags --optimized-fetch --prune --force-sync -j8

# build r
source build/envsetup.sh
lunch evolution_tb128fu-user
mka evolution
