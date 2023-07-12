# sync rom
repo init --depth=1 --no-repo-verify -u https://github.com/Project-Awaken/android_manifest.git -b triton -g default,-mips,-darwin,-notdefault
git clone https://github.com/z3zens/local_manifest.git --depth 1 -b yaap .repo/local_manifests
repo sync -c --no-clone-bundle --no-tags --optimized-fetch --prune --force-sync -j8
