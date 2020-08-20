#!/usr/bin/env bash

# APT 
apt -y update
# TODO: surveiller les mise à jour de l'AMI Ubuntu 18.04
# la mise à jour du kernel bloque
#apt -y -o Dpkg::Options::="--force-confnew" upgrade
apt -y install dirmngr
apt -y install git
cat > /etc/apt/sources.list.d/ansible.list <<EOF
deb http://ppa.launchpad.net/ansible/ansible/ubuntu trusty main
EOF
apt-key adv --keyserver keyserver.ubuntu.com --recv-keys 93C4A3FD7BB9C367
apt -y update
apt -y install ansible

# Quick and not that dirty
install -d -m 700 /root/.ssh
base64 -d > /root/.ssh/id_rsa <<EOF
PRIVKEY
EOF

install -d -m 700 -u ubuntu -g ubuntu /home/ubuntu/.ssh
base64 -d > /home/ubuntu/.ssh/id_rsa <<EOF
PRIVKEY
EOF

chmod -R u+rwX,go= /root/.ssh
chmod -R u+rwX,go= /home/ubuntu/.ssh
chown -R ubuntu:ubuntu /home/ubuntu/.ssh

cat > /home/ubuntu/check_node_ci <<'EOF'
#!/usr/bin/env bash

for i in $*
do
  echo -en "Node : ${i}\t"
  ssh -o StrictHostKeyChecking=no $i "ls /tmp/cloud-init* 2> /dev/null" 2> /dev/null
  echo
done
EOF

chown ubuntu:ubuntu /home/ubuntu/check_node_ci
chmod +x ubuntu:ubuntu /home/ubuntu/check_node_ci

date > /tmp/cloud-init-bastion-ok

