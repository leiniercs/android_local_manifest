#export ROM_DIR="roms/$DEVICE/$ROM/$FLAVOR"

# Publish
#cd $ROM_DIR
cd ~
ROM_FILE=$(basename out/target/product/$DEVICE/*.zip)
curl --upload-file out/target/product/$DEVICE/$ROM_FILE https://transfer.sh/$ROM_FILE

# Clean
#rm -fr out
