export NCPU=$(nproc --all)
#export NCPU=64
export CCACHE_EXEC=$(which ccache)
export BUILD_HOSTNAME="cirrus-ci.org"
export DEVICE="dandelion"
export ROM_NAME="crdroidandroid"
export ROM_BRANCH="12.1"
export ROM_DIR="roms/$ROM_NAME/$ROM_BRANCH"

# Build
cd ~/$ROM_DIR
source build/envsetup.sh
brunch aosp_$DEVICE-userdebug
#mka bacon -j$NCPU

# Terminate GPG Agent daemon
#pkill gpg-agent
