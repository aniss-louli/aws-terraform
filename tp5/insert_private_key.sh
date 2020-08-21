#!/usr/bin/env bash

data=$( base64 -w 0 ../ssh-keys/id_rsa_instances )
sed -e "s/^PRIVKEY.*/${data}/" < bastion_init.tmpl.sh > bastion_init.sh