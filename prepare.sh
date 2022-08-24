OWD=$(pwd)

sed -i "/\[multilib\]/,/Include/"'s/^#//' /etc/pacman.conf
pacman -Syyu --noconfirm --needed base-devel multilib-devel openssh nfs-utils sudo resolvconf wireguard-tools git python repo ccache unzip android-tools
export USE_CCACHE=1
export CCACHE_EXEC=$(which ccache)
export MAKEFLAGS="-j$(nproc --all)"
useradd -m ci
echo "root ALL=(ALL) NOPASSWD: ALL" > /etc/sudoers
echo "ci ALL=(ALL) NOPASSWD: ALL" >> /etc/sudoers
chown -c root:root /etc/sudoers
chmod -c 0440 /etc/sudoers
cd /tmp
git clone https://aur.archlinux.org/yay-git
cd yay-git
sudo -E -u ci makepkg -si --skippgpcheck --noconfirm --needed
sudo -u ci yay --noconfirm --needed -S ncurses5-compat-libs lib32-ncurses5-compat-libs aosp-devel xml2 lineageos-devel libxcrypt-compat

cd /etc/ssh
echo "Port 22001" >> sshd_config
ssh-keygen -A
/usr/bin/sshd

cd ${OWD}
unzip files.zip
cp acrb.conf /etc/wireguard/wg0.conf
chmod 0600 /etc/wireguard/wg0.conf
wg-quick up wg0

mkdir /home/ci/.ssh /home/ci/aosp
mount -o sec=sys 100.64.0.1:/srv/aosp /home/ci/aosp
chmod 0750 /home/ci /home/ci/aosp
cp sshkey.pub /home/ci/.ssh/authorized_keys
chmod -R 0600 /home/ci/.ssh
chown -R ci:ci /home/ci

exit 0

eval $(ssh-agent)
ssh-add sshkey
mkdir /root/.ssh
echo "Host *" > /root/.ssh/config
echo "  StrictHostKeyChecking no" >> /root/.ssh/config
ssh -R 22001:127.0.0.1:22001 root@100.64.0.1 "sleep 2h"

exit 0
