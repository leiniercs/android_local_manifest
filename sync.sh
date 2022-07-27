# Start GPG Agent daemon
#eval $(gpg-agent --daemon)

# Create working directory
mkdir -p $DEVICE/$ROM
cd $DEVICE/$ROM

# Initialize the repository
repo init --depth=1 --manifest-url=https://github.com/PixelExperience/manifest --branch=twelve-plus --groups=default,-device,-mips,-darwin,-notdefault
mkdir .repo/local_manifests
mv ~/local_manifest.xml .repo/local_manifests/

# Sync the repository
repo sync --jobs=$NCPU --current-branch --no-tags --no-clone-bundle --optimized-fetch --force-sync
