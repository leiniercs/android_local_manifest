# Publish the built ROM
ROM_FILE=$(basename /home/$BUILD_USERNAME/$ROM_DIR/out/target/product/$DEVICE/*.zip)
curl --upload-file /home/$BUILD_USERNAME/$ROM_DIR/out/target/product/$DEVICE/$ROM_FILE https://transfer.sh/$ROM_FILE

# Clean
#rm -fr out
