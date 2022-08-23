# Build
cd ~/aosp
source build/envsetup.sh
lunch ${ROM_BUILD}
mka bacon -j16

