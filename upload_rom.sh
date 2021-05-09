#!/bin/bash

set -exv

# Upload ROM
upload(){
	curl -T $1 https://oshi.at
}

upload out/target/product/daisy/*.zip
