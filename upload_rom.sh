#!/bin/bash

set -exv

up () {
  curl --upload-file $1 https://transfer.sh/$(basename $1); echo
}

up out/target/product/begonia/*.zip
