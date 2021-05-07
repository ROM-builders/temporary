#!/bin/bash

set -exv

# Upload rom
up(){
	curl --upload-file "$1" https://transfer.sh/"$(basename "$1")"; echo
}

for LOOP in out/target/product/mido/*.zip; do
	up "$LOOP"
	echo "$LOOP"
done
