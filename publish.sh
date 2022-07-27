# Publish
ROM_FILE=$(basename $ROM_DIR/out/target/product/$DEVICE/*.zip)
curl --upload-file $ROM_DIR/out/target/product/$DEVICE/$ROM_FILE https://transfer.sh/$ROM_FILE

# Clean
rm -fr $ROM_DIR/out
