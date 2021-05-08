#!/bin/bash

set -exv

. build/envsetup.sh
lunch aosip_ysl-userdebug
time m kronic
