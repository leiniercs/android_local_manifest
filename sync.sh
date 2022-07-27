export NCPU=$(nproc --all)
export ROM_DIR="roms/$DEVICE/$ROM/$FLAVOR"

# Start GPG Agent daemon
#eval $(gpg-agent --daemon)

# Create working directory
mkdir -p $ROM_DIR
cd $ROM_DIR

# Initialize the repository
repo init --manifest-url=https://github.com/$ROM/manifest --manifest-branch=$FLAVOR --groups=default,-darwin,-mips,-notdefault
mkdir .repo/local_manifests
cp ~/local_manifest.xml .repo/local_manifests/

# Sync the repository
repo sync --jobs=$NCPU --current-branch --no-clone-bundle --optimized-fetch
