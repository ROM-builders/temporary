#!/bin/bash

MANIFEST=https://github.com/Evolution-X/manifest
BRANCH=elle

# Initializing Source
repo init --no-repo-verify --depth=1 -u "$MANIFEST" -b "$BRANCH" -g default,-device,-mips,-darwin,-notdefault
git config --global user.name AhmedElwakil2004
git config --global user.email ahmedbasha243@gmail.com

# Clone Local Manifest
git clone https://github.com/AhmedElwakil2004/local_manifest_test.git --depth 1 -b main .repo/local_manifests

# Sync Sources
repo sync -c --no-clone-bundle --no-tags --optimized-fetch --prune --force-sync -j$(nproc --all)
