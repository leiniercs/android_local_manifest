exit 0
# Publish the built ROM
cd cd $CIRRUS_WORKING_DIR/$DEVICE/$ROM
ROM_FILE=$(basename out/target/product/$DEVICE/*.zip)
curl --upload-file out/target/product/$DEVICE/$ROM_FILE https://transfer.sh/$ROM_FILE
rm -fr out
