#!/bin/sh

# Start GPG Agent daemon
eval $(gpg-agent --daemon)

# Create working directory
mkdir -p $CIRRUS_WORKING_DIR/$DEVICE/$ROM
cd $CIRRUS_WORKING_DIR/$DEVICE/$ROM

# Initialize the repository
repo init -u https://github.com/PixelExperience/manifest -b twelve-plus -g default,-mips,-darwin,-notdefault
mkdir .repo/local_manifests
mv $CIRRUS_WORKING_DIR/local_manifest.xml .repo/local_manifests/

# Sync the repository
repo sync -j$CIRRUS_CPU -c --no-tags --no-clone-bundle --prune --force-sync --quiet

exit 0
