export NCPU=$(nproc --all)
export ROM_DIR="roms/$DEVICE/$ROM/$FLAVOR"

# Build
cd $ROM_DIR
source build/envsetup.sh
lunch aosp_$DEVICE-user
$BUILD_COMMAND -j$NCPU

# Terminate GPG Agent daemon
#pkill gpg-agent
