# Prepare environment
. env.sh

# Preparing the ROM folder
cp local_manifest.xml ~/
cd ~/aosp

# Setting up Git
git config --global user.name "${GIT_NAME}"
git config --global user.email "${GIT_EMAIL}"

# Initialize the repository
repo init --manifest-url=https://github.com/${ROM_REPO} --manifest-branch=${ROM_BRANCH} --depth=1 --groups=default,-darwin,-mips,-notdefault
mkdir -p .repo/local_manifests
mv ~/local_manifest.xml .repo/local_manifests/

# Sync the repository
repo sync --jobs=8 --current-branch --no-clone-bundle --optimized-fetch --quiet
