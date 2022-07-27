# Set up environment
export NCPU=$(nproc --all)
cd $DEVICE/$ROM
source build/envsetup.sh

# Choose a target
lunch aosp_$DEVICE-user

# Build the code
export CCACHE_EXEC=$(which ccache)
export TZ=UTC
mka bacon -j$NCPU

# Terminate GPG Agent daemon
#pkill gpg-agent
