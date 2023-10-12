#!/usr/bin/env bash

set -e
export CCACHE_DIR=~/ccache/$rom_name/$device
ccache -s
