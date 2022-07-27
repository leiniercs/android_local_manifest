# Publish the built ROM
cd $DEVICE/$ROM
ROM_FILE=$(basename out/target/product/$DEVICE/*.zip)
curl --upload-file out/target/product/$DEVICE/$ROM_FILE https://transfer.sh/$ROM_FILE

# Clean
rm -fr out

cd ../..
