
export ROM_DIR="roms/$ROM_NAME/$ROM_BRANCH"

# Preparing the ROM folder
#mv local_manifest.xml ~/
cd ~
CURDIR=$(pwd)
mkdir roms
sudo service rpcbind start
#sudo service nfs-common start
#sudo mount -v -o uid=1000,gid=1000 -t cifs //100.64.0.1/aosp $CURDIR/roms
sudo mount -v -o udp,noatime,intr,ro 168.235.81.234:/ $CURDIR/roms
#sudo mount -v 100.64.0.1:/ $CURDIR/roms
#sudo mount -v [2604:180:f3::421]:/ /srv
ls -l roms/
#sudo mount -t cifs -v -o ro //168.235.81.234/aosp $CURDIR/roms

# Setting up Git
git config --global user.name "$GIT_NAME"
git config --global user.email "$GIT_EMAIL"

exit 0


# Start GPG Agent daemon
#eval $(gpg-agent --daemon)

# Create working directory
if [ ! -d ~/$ROM_DIR ]; then
  mkdir -p ~/$ROM_DIR
fi
cd ~/$ROM_DIR

# Initialize the repository
if [ ! -e .repo_initiated ]; then
  repo init --manifest-url=https://github.com/$ROM_NAME/$ROM_MANIFEST --manifest-branch=$ROM_BRANCH --depth=1 --groups=default,-darwin,-mips,-notdefault
  mkdir -p .repo/local_manifests
  touch .repo_initiated
fi
cp ~/local_manifest.xml .repo/local_manifests/

# Sync the repository
repo sync --jobs=8 --current-branch --no-clone-bundle --optimized-fetch
