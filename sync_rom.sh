#!/bin/bash

set -exv

# Init Repo
repo init --no-repo-verify --depth=1 -u https://github.com/AOSPA/manifest -b ruby -g default,-device,-mips,-darwin,-notdefault

# Device sources
git clone https://github.com/AOSPA-Sakura/sakura_local_manifests .repo/local_manifests

# TMP fix for sync fail
rm -rf cts

# Sync Repo
repo sync -c --no-clone-bundle --no-tags --optimized-fetch --prune --force-sync -j$(nproc --all)

