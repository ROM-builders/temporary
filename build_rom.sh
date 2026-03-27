# Initialize and sync the rom
repo init --depth=1 --no-repo-verify -u https://github.com/LineageOS/android.git -b lineage-23.2 --git-lfs -g default,-mips,-darwin,-notdefault

# Clone local manifest
git clone https://github.com/nuruszama/local_manifest.git --depth 1 -b main .repo/local_manifests

# Use 'crave_run' for the actual sync
crave run -- "repo sync -c --no-clone-bundle --no-tags --optimized-fetch --prune --force-sync -j$(nproc --all)"

# Build the rom
source build/envsetup.sh
lunch lineage_creek-userdebug
export TZ=Asia/Dhaka

# Use 'crave run' for the build to utilize 96+ CPU cores
crave run -- "mka bacon"

# Skip rom upload for now
