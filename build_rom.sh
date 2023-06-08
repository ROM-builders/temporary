# Initialize local repository
repo init -u https://github.com/Evolution-X/manifest -b tiramisu

# Sync
repo sync -c -j$(nproc --all) --force-sync --no-clone-bundle --no-tags

# Set up environment
$ . build/envsetup.sh

# Choose a target
$ lunch evolution_$device-userdebug

# Build the code
$ mka evolution