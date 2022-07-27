export NCPU=$(nproc)

# Set up environment
sudo -u $BUILD_USERNAME -D $ROM_DIR source build/envsetup.sh

# Choose a target
sudo -u $BUILD_USERNAME -D $ROM_DIR lunch aosp_$DEVICE-user

# Build the code
sudo -u $BUILD_USERNAME -D $ROM_DIR export CCACHE_EXEC=$(which ccache) && export TZ=UTC && mka bacon -j$NCPU

# Terminate GPG Agent daemon
#pkill gpg-agent
