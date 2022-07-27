export ROM_DIR="roms/$DEVICE/$ROM/$FLAVOR"

# Setting up Git
git config --global user.name "$GIT_NAME"
git config --global user.email "$GIT_EMAIL"

# Start GPG Agent daemon
#eval $(gpg-agent --daemon)

# Create working directory
if [ ! -d $ROM_DIR ]; then
  mkdir -p $ROM_DIR
fi
cd $ROM_DIR

# Initialize the repository
if [ ! -e .repo_initiated ]; then
  repo init --manifest-url=https://github.com/$ROM/manifest --manifest-branch=$FLAVOR --groups=default,-darwin,-mips,-notdefault
  mkdir -p .repo/local_manifests
  touch .repo_initiated
fi
cp ../../../../local_manifest.xml .repo/local_manifests/

# Sync the repository
repo sync --jobs=8 --current-branch --no-clone-bundle --optimized-fetch
