 #!/bin/bash

set -exv

# sync rom
repo init --depth=1 -u https://github.com/PixelPlusUI-Elle/manifest -b eleven
git clone https://github.com/asus-tree-4-19/local_manifests.git --depth 1 -b main .repo/local_manifests
repo sync -c --no-clone-bundle --no-tags --optimized-fetch --prune --force-sync -j$(nproc --all)
