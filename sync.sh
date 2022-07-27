export NCPU=$(nproc --all)
alias exec_sudo="sudo -u $BUILD_USERNAME -H -n"

# Start GPG Agent daemon
#eval $(gpg-agent --daemon)

# Create working directory
exec_sudo mkdir -p $ROM_DIR
alias exec_sudo="sudo -u $BUILD_USERNAME -H -n -D $ROM_DIR"

# Initialize the repository
exec_sudo repo init --manifest-url=https://github.com/PixelExperience/manifest --manifest-branch=twelve-plus --groups=default,-darwin,-mips,-notdefault
exec_sudo  mkdir .repo/local_manifests
cp ../../local_manifest.xml /tmp/
exec_sudo cp /tmp/local_manifest.xml .repo/local_manifests/

# Sync the repository
exec_sudo repo sync --jobs=$NCPU --current-branch --no-clone-bundle --optimized-fetch
