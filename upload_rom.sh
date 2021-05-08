#!/bin/bash

set -exv

# Upload ROM
upload(){
	curl --upload-file $1 https://transfer.sh/$(basename $1); echo
	# 14 days, 10 GB limit
}

upload out/target/product/daisy/*.zip
