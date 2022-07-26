#!/bin/sh

# Create the build directory
mkdir -p $CIRRUS_WORKING_DIR/build
cd $CIRRUS_WORKING_DIR/build

# Set up environment
export TOP=$CIRRUS_WORKING_DIR/$DEVICE/$ROM
source $TOP/build/envsetup.sh

# Choose a target
lunch aosp_$DEVICE-user

# Build the code
export TZ=UTC
mka bacon -j$CIRRUS_CPU

# Terminate GPG Agent daemon
pkill gpg-agent

# Publish the built ROM
ROM_FILE=$(basename out/target/product/$DEVICE/*.zip)
curl --upload-file out/target/product/$DEVICE/$ROM.zip https://transfer.sh/$ROM_FILE.zip

exit 0
