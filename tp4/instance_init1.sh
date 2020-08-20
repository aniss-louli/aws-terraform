#!/usr/bin/env bash

# APT 
apt -y update
#apt -y -o Dpkg::Options::="--force-confnew" upgrade
apt -y install dirmngr
apt -y install git
cat > /etc/apt/sources.list.d/ansible.list <<EOF
deb http://ppa.launchpad.net/ansible/ansible/ubuntu trusty main
EOF
apt-key adv --keyserver keyserver.ubuntu.com --recv-keys 93C4A3FD7BB9C367
apt -y update
apt -y install ansible

date > /tmp/cloud-init-ok

