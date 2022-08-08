ROM_DIR="roms/$ROM_NAME/$ROM_BRANCH"

# Preparing the ROM folder
mv local_manifest.xml ~/
mkdir -p ~/$ROM_DIR
cd ~/$ROM_DIR

# Setting up Git
git config --global user.name "$GIT_NAME"
git config --global user.email "$GIT_EMAIL"

# Initialize the repository
repo init --manifest-url=https://github.com/$ROM_NAME/$ROM_MANIFEST --manifest-branch=$ROM_BRANCH --depth=1 --groups=default,-darwin,-mips,-notdefault
mkdir -p .repo/local_manifests
cp ~/local_manifest.xml .repo/local_manifests/

# Sync the repository
ulimit -Sv 8388608
repo sync --jobs=8 --current-branch --no-clone-bundle --optimized-fetch
ulimit -Sv unlimited
