exit 0
# Set up environment
cd $CIRRUS_WORKING_DIR/$DEVICE/$ROM
source build/envsetup.sh

# Choose a target
lunch aosp_$DEVICE-user

# Build the code
export TZ=UTC
mka bacon -j$CIRRUS_CPU

# Terminate GPG Agent daemon
pkill gpg-agent
