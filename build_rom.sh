#!/bin/bash

set -exv

# Initializing build
source build/envsetup.sh
lunch evolution_mido-user

# Make Metalava
make api-stubs-docs || echo no problem
make system-api-stubs-docs || echo no problem
make test-api-stubs-docs || echo no problem

# Build Rom
make bacon -j10

