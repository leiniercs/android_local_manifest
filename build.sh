export NCPU=$(nproc --all)
#export NCPU=64
export CCACHE_EXEC=$(which ccache)
export BUILD_HOSTNAME="cirrus-ci.org"
export DEVICE="dandelion"
export ROM_NAME="PixelExperience"
export ROM_BRANCH="twelve-plus"
export ROM_DIR="roms/$ROM_NAME/$ROM_BRANCH"
export OUT_DIR="~/out"

# Build
cd ~/$ROM_DIR
source build/envsetup.sh
lunch aosp_$DEVICE-userdebug
#m bacon -j$NCPU
m selinux -j$NCPU
m bootimage -j$NCPU
m init -j$NCPU

# Terminate GPG Agent daemon
#pkill gpg-agent
