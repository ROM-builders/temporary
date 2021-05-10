#!/bin/bash

set -exv

# build rom
. build/envsetup.sh
lunch arrow_RMX1941-userdebug
chmod -R 755 out/
m bacon
