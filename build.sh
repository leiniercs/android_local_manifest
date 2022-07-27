export NCPU=$(nproc --all)

# Build
source build/envsetup.sh
lunch aosp_$DEVICE-user
mka bacon -j$NCPU

# Terminate GPG Agent daemon
#pkill gpg-agent
