#!/bin/bash

set -exv

#uild rom
. build/envsetup.sh
lunch aosip_ysl-userdebug
time m kronic
