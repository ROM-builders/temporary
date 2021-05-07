#!/bin/bash

set -exv

# Upload Rom
echo -e "Uploading PE build"
up(){
	curl --upload-file $1 https://transfer.sh/$(basename $1); echo
	# 14 days, 10 GB limit
}

up out/target/product/ysl/*.zip
