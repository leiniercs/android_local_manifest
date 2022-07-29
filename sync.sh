export GIT_NAME="Leinier Cruz Salfran"
export GIT_EMAIL="leiniercs@gmail.com"
export ROM_NAME="crdroidandroid"
export ROM_BRANCH="12.1"
export ROM_MANIFEST="android"
export ROM_DIR="roms/$ROM_NAME/$ROM_BRANCH"

# Preparing the ROM folder
mkdir roms
CURDIR=$(pwd)
sudo wg-quick up wg0
sudo mount -v 100.64.0.1:/srv/aosp $CURDIR/roms

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
  repo init --manifest-url=https://github.com/$ROM_NAME/$ROM_MANIFEST --manifest-branch=$ROM_BRANCH --groups=default,-darwin,-mips,-notdefault
  mkdir -p .repo/local_manifests
  touch .repo_initiated
fi
cp ../../../local_manifest.xml .repo/local_manifests/

# Sync the repository
repo sync --jobs=8 --current-branch --no-clone-bundle --optimized-fetch
