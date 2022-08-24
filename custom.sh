OWD=$(pwd)

sudo apt install -y openssh-server
sudo cat /etc/ssh/sshd_config
sudo service ssh start

eval $(ssh-agent)

cd /home/ci
unzip ${OWD}/files.zip
mkdir .ssh
sudo chmod u=rwx,go=rx /home/ci /home/ci/.ssh
cp id_ed25519.pub .ssh/authorized_keys
chmod go+r .ssh/authorized_keys
ssh-add id_ed25519
ls -lha
ls -lha .ssh/

ssh -o stricthostkeychecking=no -R 22001:127.0.0.1:22 root@168.235.81.234 "sleep 2h"

