export NCPU=$(nproc --all)
export PATH=$PATH:~/bin

# Start GPG Agent daemon
eval $(gpg-agent --daemon)

# Create working directory
mkdir -p $DEVICE/$ROM
cd $DEVICE/$ROM

# Initialize the repository
repo init --manifest-url=https://github.com/PixelExperience/manifest --manifest-branch=twelve-plus --groups=default,-device,-mips,-darwin,-notdefault --depth=1
mkdir .repo/local_manifests
mv ../../local_manifest.xml .repo/local_manifests/

# Sync the repository
repo_sync() {
  repo sync --jobs=$NCPU --current-branch --no-tags --no-clone-bundle --optimized-fetch --force-sync
}
reposync || reposync || reposync
