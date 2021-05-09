#!/bin/bash

# build rom
source build/envsetup.sh
lunch p404_whyred-userdebug
make bacon
