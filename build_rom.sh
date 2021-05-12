#!/bin/bash

set -exv

ls

. build/envsetup.sh
lunch aosip_ysl-userdebug
time m kronic
