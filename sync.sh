export NCPU=$(nproc)
export PATH=$PATH:~/bin


# Start GPG Agent daemon
#eval $(gpg-agent --daemon)

# Create working directory
mkdir -p $DEVICE/$ROM
cd $DEVICE/$ROM

# Initialize the repository
repo init --manifest-url=https://github.com/PixelExperience/manifest --manifest-branch=twelve-plus --groups=default,-darwin,-mips,-notdefault
mkdir .repo/local_manifests
mv ../../local_manifest.xml .repo/local_manifests/

# Sync the repository
repo sync --jobs=$NCPU || repo sync

cd ../..
