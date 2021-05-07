#!/bin/bash

set -exv

# Build rom
source build/envsetup.sh
lunch aosp_mido-user

make api-stubs-docs || echo skip
make system-api-stubs-docs || echo skip
make test-api-stubs-docs || echo skip
make aex -j"$(nproc --all)"
