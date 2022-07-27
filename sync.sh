export NCPU=$(nproc -all)

# Start GPG Agent daemon
#eval $(gpg-agent --daemon)

# Create working directory
sudo -u $BUILD_USERNAME mkdir -p $ROM_DIR

# Initialize the repository
sudo -u $BUILD_USERNAME -D $ROM_DIR repo init --manifest-url=https://github.com/PixelExperience/manifest --manifest-branch=twelve-plus --groups=default,-darwin,-mips,-notdefault
sudo -u $BUILD_USERNAME -D $ROM_DIR mkdir .repo/local_manifests
cp ../../local_manifest.xml /tmp/
sudo -u $BUILD_USERNAME -D $ROM_DIR cp /tmp/local_manifest.xml .repo/local_manifests/

# Sync the repository
sudo -u $BUILD_USERNAME -D $ROM_DIR repo sync --jobs=$NCPU --current-branch --no-clone-bundle --optimized-fetch
