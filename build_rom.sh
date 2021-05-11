#!/bin/bash

set -exv

#uild rom
. build/envsetup.sh
lunch crdroid_ysl-userdebug
brunch ysl
