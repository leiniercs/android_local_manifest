export NCPU=$(nproc --all)
export CCACHE_EXEC=$(which ccache)
export ROM_DIR="roms/$ROM_NAME/$ROM_BRANCH"

# Build
cd ~/$ROM_DIR
ulimit -Sv 32000000
source build/envsetup.sh
lunch lineage_$DEVICE-userdebug
mka bacon -j$NCPU
#m sepolicy -j$NCPU
#m bootimage -j$NCPU
#m init -j$NCPU

# Terminate GPG Agent daemon
#pkill gpg-agent

