# Start GPG Agent daemon
eval $(gpg-agent --daemon)

# Create working directory
mkdir -p $CIRRUS_WORKING_DIR/$DEVICE/$ROM
cd $CIRRUS_WORKING_DIR/$DEVICE/$ROM

# Initialize the repository
repo init --depth=1 --manifest-url=https://github.com/PixelExperience/manifest --branch=twelve-plus --current-branch --no-tags --no-clone-bundle
mkdir .repo/local_manifests
mv $CIRRUS_WORKING_DIR/local_manifest.xml .repo/local_manifests/

# Sync the repository
repo sync --jobs=$CIRRUS_CPU --current-branch --no-tags --no-clone-bundle --optimized-fetch --force-sync
