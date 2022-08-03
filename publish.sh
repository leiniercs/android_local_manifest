export ROM_DIR="roms/$ROM_NAME/$ROM_BRANCH"

# Publish
cd ~/$ROM_DIR
ROM_FILE=$(basename out/target/product/$DEVICE/*.zip)
curl --upload-file out/target/product/$DEVICE/$ROM_FILE https://transfer.sh/$ROM_FILE
