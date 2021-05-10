#!/bin/bash

set -e
set -x

# build rom
. build/envsetup.sh
lunch arrow_RMX1941-userdebug
chmod -R 755 out/
m bacon
