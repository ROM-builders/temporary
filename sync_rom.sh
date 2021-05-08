#!/bin/bash

set -exv

# Init ROM source
repo init -u git://github.com/LineageOS/android.git -b lineage-18.1 --depth=1

# Clone local manifest
git clone https://github.com/LinkBoi00/linkmanifest -b eleven .repo/local_manifests

# Sync ROM source, DT, VT, Kernel and HALs
repo sync -j16 --optimized-fetch --no-tags --no-clone-bundle


