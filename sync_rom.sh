#!/bin/bash

set -exv

# sync rom
repo init -u git://github.com/XOSP-Reborn/manifest.git -b eleven --depth=1
git clone https://github.com/sasukeuchiha-clan/Begonia --depth=1 -b soni .repo/local_manifests
repo sync -c -j$(nproc --all) --force-sync --no-clone-bundle --no-tags
rm -rf hardware/qcom-caf*
