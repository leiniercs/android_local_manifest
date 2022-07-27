export NCPU=$(nproc --all)

# Updating sources package listings
cat << EOF > sources.list
deb http://archive.ubuntu.com/ubuntu jammy main restricted universe multiverse
deb http://archive.ubuntu.com/ubuntu jammy-updates main restricted universe multiverse
deb http://archive.ubuntu.com/ubuntu jammy-backports main restricted universe multiverse
deb http://security.ubuntu.com/ubuntu jammy-security main restricted universe multiverse
EOF
sudo cp sources.list /etc/apt/sources.list
sudo apt -y update

# Upgrading the system
sudo apt -y full-upgrade

# Installing packages
sudo apt -y install lsb-core autoconf automake axel bison \
               ccache clang cmake ninja-build soong expat flex \
               g++-multilib gawk gcc-multilib gnupg gperf \
               imagemagick lib32ncurses5-dev lib32z1-dev libtinfo5 libcap-dev \
               libexpat1-dev libmpc-dev libmpfr-dev libncurses5-dev \
               libprotobuf-dev libnl-route-3-dev libtool protobuf-compiler \
               libsdl1.2-dev libssl-dev libtool libxml2-utils '^lzma.*' lzop \
               maven ncftp ncurses-dev patchelf pkg-config pngcrush \
               pngquant python2.7 python-all-dev re2c schedtool squashfs-tools subversion \
               texinfo w3m xsltproc zlib1g-dev lzip \
               libxml-simple-perl libswitch-perl libncurses5 python-is-python3 \
               pinentry-curses gpg-agent
apt clean

# Installing Android Repository Manager
mkdir ~/bin
curl https://storage.googleapis.com/git-repo-downloads/repo > repo
chmod a+x repo
sudo mv repo /usr/bin/

# Install nsjail
git clone https://github.com/google/nsjail -b 3.1 --recurse-submodules
cd nsjail
make -j$NCPU
chmod a+x nsjail
sudo mv nsjail /usr/bin/
cd ..
rm -fr nsjail

# Creating compilation user
useradd -ms /bin/bash -g sudo $BUILD_USERNAME
echo "$BUILD_USERNAME ALL=(ALL) NOPASSWD:ALL" >> /etc/sudoers
sudo -u $BUILD_USERNAME git config --global user.name "$GIT_NAME"
sudo -u $BUILD_USERNAME git config --global user.email "$GIT_EMAIL"

# Preparing compilation cache
sudo -u $BUILD_USERNAME mkdir -p $CCACHE_DIR
sudo -u $BUILD_USERNAME ccache --max-size=10G
sudo -u $BUILD_USERNAME ccache -z
