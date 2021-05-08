#!/bin/bash

set -exv

repo init -u  git://github.com/AOSiP/platform_manifest.git -b eleven --depth=1
git clone https://github.com/flashokiller/android_.repo_local_manifests --depth=1  .repo/local_manifests -b aex
repo sync --force-sync --no-tags --no-clone-bundle
