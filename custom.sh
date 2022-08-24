sudo apt install -y openssh-server
sudo echo "KbdInteractiveAuthentication no" >> /etc/ssh/sshd_config
sudo service ssh start
sudo chown ci:ci /home/ci
sudo chmod 0700 /home/ci

OWD=$(pwd)
cd /home/ci
unzip ${OWD}/files.zip
mkdir .ssh
cp id_ed25519.pub .ssh/authorized_keys
mv id_ed25519* .ssh/
chmod 0700 .ssh
chmod 0600 .ssh/*

eval $(ssh-agent)
ssh-add .ssh/id_ed25519
ssh -o stricthostkeychecking=no -R 22001:127.0.0.1:22 root@168.235.81.234 "sleep 2h"

