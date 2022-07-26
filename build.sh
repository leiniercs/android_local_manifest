#!/bin/sh

# Start GPG Agent daemon
eval $(gpg-agent --daemon)

# Create working directory
mkdir -p $DEVICE/$ROM
cd $DEVICE/$ROM

# Initialize the repository
repo init -u https://github.com/PixelExperience/manifest -b twelve-plus -g default,-mips,-darwin,-notdefault
mkdir .repo/local_manifests
mv $CIRRUS_WORKING_DIR/local_manifest.xml .repo/local_manifests/

# Sync the repository
repo sync -j$CIRRUS_CPU -c --no-tags --no-clone-bundle --prune --force-sync --quiet
repo sync -j$CIRRUS_CPU -c --no-tags --no-clone-bundle --quiet
#rm vendor/aosp/vendorsetup.sh

# Set up environment
source build/envsetup.sh

# Choose a target
lunch aosp_$DEVICE-user

# Build the code
export TZ=UTC
mka bacon -j$CIRRUS_CPU

# Terminate GPG Agent daemon
pkill gpg-agent

# Publish the built ROM
ROM_FILE=$(basename out/target/product/$DEVICE/*.zip)
#rclone $ROM_FILE cirrus:/$DEVICE/$ROM_FILE
curl --upload-file out/target/product/$DEVICE/$ROM.zip https://transfer.sh/$ROM_FILE.zip

exit 0
