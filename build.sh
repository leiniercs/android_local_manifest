#!/usr/bin/bash

# Prepare environment
source /tmp/cirrus-ci-build/env.sh
cd ~/aosp/lineageos

# Build
source build/envsetup.sh
lunch ${ROM_BUILD}
mka bacon -j16

