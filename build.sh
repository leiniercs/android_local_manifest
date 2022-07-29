export NCPU=$(nproc --all)
export CCACHE_EXEC=$(which ccache)
export BUILD_HOSTNAME="cirrus-ci.org"
export DEVICE="garden"
export ROM_NAME="crdroidandroid"
export ROM_BRANCH="12.1"
export ROM_DIR="roms/$ROM_NAME/$ROM_BRANCH"

# Build
cd $ROM_DIR
source build/envsetup.sh
lunch lineage_$DEVICE-user
export TZ="UTC"
m bacon -j$NCPU

# Terminate GPG Agent daemon
#pkill gpg-agent
