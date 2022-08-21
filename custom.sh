sudo apt install -y openssh-server
sudo service ssh start

OWD=$(pwd)
cd ~
sudo mkdir /root/.ssh
mkdir .ssh
sudo cp ${OWD}/id_ed25519.pub /root/.ssh/authorized_keys
sudo cp ${OWD}/id_ed25519.pub /home/ci/.ssh/authorized_keys
sudo cp ${OWD}/id_ed25519 /home/ci/.ssh/
sudo chown root:root /root/.ssh/*
sudo chown ci:ci /home/ci/.ssh/*
sudo chmod go-r /root/.ssh/*
chmod go-r .ssh/*

ssh -o stricthostkeychecking=no -R 22001:127.0.0.1:22 root@168.235.81.234 "sleep 2h"

exit 0
