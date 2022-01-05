#!/bin/bash

set -exv

# Init Repo
repo init --no-repo-verify --depth=1 -u https://github.com/AOSPA/manifest -b sapphire -g default,-device,-mips,-darwin,-notdefault

# Device sources
git clone https://github.com/HimanishM25/local_manifest .repo/local_manifests

# Sync Repo
repo sync -c --no-clone-bundle --no-tags --optimized-fetch --prune --force-sync -j$(nproc --all)
