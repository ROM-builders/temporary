#!/bin/bash

set -exv

. build/envsetup.sh
lunch crdroid_ysl-userdebug
brunch ysl
