#!/bin/sh

# Start GPG Agent daemon
eval $(gpg-agent --daemon)

# Create working directory
mkdir -p $ROM
cd $ROM

# Initialize the repository
repo init -u https://github.com/PixelExperience/manifest -b twelve-plus
mkdir .repo/local_manifests
mv $CIRRUS_WORKING_DIR/local_manifest.xml .repo/local_manifests/

# Sync the repository
repo sync -j$CIRRUS_CPU --no-tags --no-clone-bundle --prune --force-sync --quiet
#rm vendor/aosp/vendorsetup.sh

# Set up environment
source build/envsetup.sh
export CUSTOM_VERSION=$CUSTOM_VERSION-R

# Choose a target
lunch aosp_$DEVICE-user

# Build the code
mka bacon -j$CIRRUS_CPU

# Terminate GPG Agent daemon
pkill gpg-agent

# Publish the built ROM
#ROM_FILE=$(basename out/target/product/$DEVICE/$CUSTOM_VERSION.zip)
#rclone $ROM_FILE cirrus:/$DEVICE/$ROM_FILE
curl --upload-file out/target/product/$DEVICE/$CUSTOM_VERSION.zip https://transfer.sh/$CUSTOM_VERSION.zip

exit 0
