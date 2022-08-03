export NCPU=$(nproc --all)
#export NCPU=64
export CCACHE_EXEC=$(which ccache)
export ROM_DIR="roms/$ROM_NAME/$ROM_BRANCH"

# Build
cd ~/$ROM_DIR
source build/envsetup.sh
brunch lineage_$DEVICE-userdebug
#mka bacon -j$NCPU

# Terminate GPG Agent daemon
#pkill gpg-agent
