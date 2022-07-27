export NCPU=$(nproc)
alias exec_sudo="sudo -u $BUILD_USERNAME -H -n -D $ROM_DIR"

# Set up environment
exec_sudo source build/envsetup.sh && lunch aosp_$DEVICE-user && export CCACHE_EXEC=$(which ccache) && export TZ=UTC && mka bacon -j$NCPU

# Terminate GPG Agent daemon
#pkill gpg-agent
