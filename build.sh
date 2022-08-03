export NCPU=$(nproc --all)
#export NCPU=64
export CCACHE_EXEC=$(which ccache)
export ROM_DIR="roms/$ROM_NAME/$ROM_BRANCH"

# Build
cd ~/$ROM_DIR
source build/envsetup.sh
lunch lineage_$DEVICE-userdebug
m selinux -j$NCPU
m bootimage -j$NCPU
m init -j$NCPU

# Terminate GPG Agent daemon
#pkill gpg-agent

