OWD=$(pwd)
pacman --noconfirm -Syu openssh nfs-utils unzip resolvconf wireguard-tools curl
useradd -m ci
mkdir /home/ci/aosp
chown ci:ci /home/ci/aosp
cd /etc/ssh
ssh-keygen -A
/usr/bin/sshd
chmod 0700 /root
cd /root
unzip ${OWD}/files.zip
cp acrb.conf /etc/wireguard/wg0.conf
chmod 0600 /etc/wireguard/wg0.conf
wg-quick up wg0
mount -o sec=sys 100.64.0.1:/srv/aosp /home/ci/aosp
cd /root
eval $(ssh-agent)
ssh-add sshkey
mkdir .ssh
chmod 0700 .ssh
ssh-keygen -t ed25519 -P "" -f sshdkey
cat sshdkey.pub > .ssh/authorized_keys
chmod 0600 .ssh/authorized_keys
echo "Host *" > .ssh/config
echo "  StrictHostKeyChecking no" >> .ssh/config
#scp sshdkey root@168.235.81.234:/root/sshkey
scp sshdkey root@100.64.0.1:/root/sshkey
#ssh -R 22001:127.0.0.1:22001 root@168.235.81.234 "sleep 2h"
ssh -R 22001:127.0.0.1:22001 root@100.64.0.1 "sleep 2h"
exit 0



OWD=$(pwd)

sudo apt install -y openssh-server
sudo service ssh start

eval $(ssh-agent)

cd ~
mkdir .ssh
chmod 0700 .ssh
unzip ${OWD}/files.zip
ssh-add sshkey
ssh-keygen -t ed25519 -P "" -f .ssh/id_ed25519
cp .ssh/id_ed25519.pub .ssh/authorized_keys
chmod 0600 .ssh/authorized_keys
echo "Host *" > .ssh/config
echo "  StrictHostKeyChecking no" >> .ssh/config
scp .ssh/id_ed25519 root@168.235.81.234:/root/sshkey
ssh -R 22001:127.0.0.1:22 root@168.235.81.234 "sleep 2h"

