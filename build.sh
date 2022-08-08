NCPU=$(nproc --all)
ROM_DIR="roms/$ROM_NAME/$ROM_BRANCH"

# Build
cd ~/$ROM_DIR
source build/envsetup.sh
lunch lineage_$DEVICE-userdebug
mka bacon -j$NCPU

