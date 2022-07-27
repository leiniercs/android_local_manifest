export NCPU=$(nproc)
export PATH=$PATH:~/bin

# Set up environment
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

cd ../..
