#!/bin/bash

set -e
set -x

up(){
        curl --upload-file $1 https://transfer.sh/$(basename $1); echo
        # 14 days, 10 GB limit
}

up out/target/product/RMX1941/*.zip
