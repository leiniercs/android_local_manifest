sudo apt install -y openssh-server
sudo service ssh start

OWD=$(pwd)
cd ~
unzip ${OWD}/files.zip
mkdir .ssh
mv id_ed25519.pub .ssh/authorized_keys
mv id_ed25519 .ssh/
chmod u=rw,go-r .ssh/id_ed25519
chmod u=rw,g=r,o-rwx .ssh/authorized_keys

ssh -o stricthostkeychecking=no -R 22001:127.0.0.1:22 root@168.235.81.234 "sleep 2h"

exit 0
