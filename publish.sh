# Prepare environment
source /tmp/cirrus-ci-build/env.sh
cd ~/aosp/lineageos

# Publish
ROM_FILE=$(basename out/target/product/${DEVICE}/*.zip)
curl --upload-file out/target/product/${DEVICE}/${ROM_FILE} https://168.235.81.234/aosp/${ROM_FILE}
