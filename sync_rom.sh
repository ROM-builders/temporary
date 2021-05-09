#!/bin/bash

set -exv

# sync rom
repo init --depth=1 -u git://github.com/ProjectSakura/android.git -b 11
git clone https://github.com/Realme-G70-Series/local_manifest.git --depth=1 .repo/local_manifests
repo sync -c --no-clone-bundle --no-tags --optimized-fetch --prune --force-sync -j$(nproc --all)
git clone https://github.com/Realme-G70-Series/android_packages_apps_RealmeParts packages/apps/RealmeParts


