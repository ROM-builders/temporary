#!/bin/bash

set -exv

# Upload Rom
up(){
	curl --upload-file $1 https://transfer.sh/$(basename $1); echo
	# 14 days, 10 GB limit
}

up out/target/product/rosy/*.zip
