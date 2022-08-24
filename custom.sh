OWD=$(pwd)

sudo apt install -y openssh-server
sudo cat /etc/ssh/sshd_config
sudo service ssh start

eval $(ssh-agent)

cd /home/ci
unzip ${OWD}/files.zip
mkdir .ssh
sudo chmod 0700 /home/ci /home/ci/.ssh
cp sshkey.pub .ssh/authorized_keys
chmod 0600 .ssh/authorized_keys
ssh-add sshkey

ssh -o stricthostkeychecking=no -R 22001:127.0.0.1:22 root@168.235.81.234 "sleep 2h"

