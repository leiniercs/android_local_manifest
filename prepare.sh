OWD=$(pwd)

pacman --noconfirm -Syu openssh nfs-utils sudo resolvconf wireguard-tools curl git unzip p7zip squashfs-tools python repo

cd /etc/ssh
echo "Port 22001" >> sshd_config
ssh-keygen -A
/usr/bin/sshd

cd ${OWD}
unzip files.zip
cp acrb.conf /etc/wireguard/wg0.conf
chmod 0600 /etc/wireguard/wg0.conf
wg-quick up wg0

useradd -m ci
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
