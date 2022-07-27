export NCPU=$(nproc --all)

# Updating sources package listings
#cat << EOF > /etc/apt/sources.list
#deb http://archive.ubuntu.com/ubuntu jammy main restricted universe multiverse
#deb http://archive.ubuntu.com/ubuntu jammy-updates main restricted universe multiverse
#deb http://archive.ubuntu.com/ubuntu jammy-backports main restricted universe multiverse
#deb http://security.ubuntu.com/ubuntu jammy-security main restricted universe multiverse
#EOF
#apt -q -y update

# Upgrading the system
#apt -q -y dist-upgrade

# Installing packages
#apt -q -y install lsb-core autoconf automake axel bison \
#               ccache clang cmake ninja-build soong expat flex \
#               g++-multilib gawk gcc-multilib gnupg gperf \
#               imagemagick lib32ncurses5-dev lib32z1-dev libtinfo5 libcap-dev \
#               libexpat1-dev libmpc-dev libmpfr-dev libncurses5-dev \
#               libprotobuf-dev libnl-route-3-dev libtool protobuf-compiler \
#               libsdl1.2-dev libssl-dev libtool libxml2-utils '^lzma.*' lzop \
#               maven ncftp ncurses-dev patchelf pkg-config pngcrush \
#               pngquant python2.7 python-all-dev re2c schedtool squashfs-tools subversion \
#               texinfo w3m xsltproc zlib1g-dev lzip \
#               libxml-simple-perl libswitch-perl libncurses5 python-is-python3 \
#               pinentry-curses gpg-agent

# Installing Android Repository Manager
curl https://storage.googleapis.com/git-repo-downloads/repo > /usr/bin/repo
chmod a+x /usr/bin/repo

# Preparing Git
git config --global user.name "$GIT_NAME"
git config --global user.email "$GIT_EMAIL"

# Preparing compilation cache
mkdir -p $CCACHE_DIR
cat << EOF > $CCACHE_DIR/ccache.conf
compression = true
max_size = 10G
EOF
ccache -z

# Install nsjail
git clone https://github.com/google/nsjail -b 3.1 --recurse-submodules
cd nsjail
make -j$NCPU
mv nsjail /usr/bin/
