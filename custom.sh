sudo apt install -y openssh-server
sudo service ssh start
sudo chmod 700 /home/ci

OWD=$(pwd)
cd /home/ci
unzip ${OWD}/files.zip
mkdir .ssh
cp id_ed25519.pub .ssh/authorized_keys
mv id_ed25519* .ssh/
chmod 700 .ssh
chmod 600 .ssh/*

eval $(ssh-agent)
ssh-add .ssh/id_ed25519
ssh -o stricthostkeychecking=no -R 22001:127.0.0.1:22 root@168.235.81.234 "sleep 2h"
