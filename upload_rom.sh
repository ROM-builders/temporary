#!/bin/bash

set -exv

# Upload Function
up() {
      curl --upload-file $1 https://transfer.sh/$(basename $1); echo
      # 14 days, 10 GB limit
    }
# Upload Rom
    up out/target/product/mido/*.zip
