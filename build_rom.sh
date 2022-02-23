# sync rom
repo init --depth=1 --no-repo-verify -u https://github.com/Komodo-OS-Rom/manifest -b 11 -g default,-mips,-darwin,-notdefault
git clone https://github.com/pocox3pro/Local-Manifests.git --depth 1 -b master .repo/local_manifests
repo sync -c -j$(nproc --all) --force-sync --no-clone-bundle --no-tags


# Set up environment
$ . build/envsetup.sh

# Choose a target
$ lunch komodo_$device-userdebug

# Build the code
$ masak komodo -jX

# upload rom (if you don't need to upload multiple files, then you don't need to edit next line)
rclone copy out/target/product/$(grep unch $CIRRUS_WORKING_DIR/build_rom.sh -m 1 | cut -d ' ' -f 2 | cut -d _ -f 2 | cut -d - -f 1)/*.zip cirrus:$(grep unch $CIRRUS_WORKING_DIR/build_rom.sh -m 1 | cut -d ' ' -f 2 | cut -d _ -f 2 | cut -d - -f 1) -P
