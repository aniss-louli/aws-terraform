all: bastion_init.sh #node_init.sh

bastion_init.sh: bastion_init.tmpl.sh ../ssh-keys/id_rsa_bastion insert_private_key.sh
	./insert_private_key.sh
	chmod +x bastion_init.sh

#node_init.sh: node_init.tmpl.sh ../ssh-keys/id_rsa_aws_int.pub
#	./insert_public_key.sh
#	chmod +x node_init.sh

../ssh-keys/id_rsa_bastion:
	cd ../ssh-keys/ && ./generate_keys

clean:
	rm -f bastion_init.sh node_init.sh
