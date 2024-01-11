#!/bin/bash

# export DEBIAN_FRONTEND=noninteractive

echo "probably age key: $SOPS_AGE_KEY"

sudo apt-get update
sudo apt-get install -y curl git

# # Instal sops
# curl -LO https://github.com/getsops/sops/releases/download/v3.8.1/sops-v3.8.1.linux.amd64
# sudo mv sops-v3.8.1.linux.amd64 /usr/local/bin/sops
# sudo chmod +x /usr/local/bin/sops
# echo "Installed sops version: $(sops --version)"

# Install Cinc
curl -L https://omnitruck.cinc.sh/install.sh | sudo bash
echo "Installed Cinc"

# Mock clone chef repo
# sudo sh -c 'ssh-keyscan -H github.com >> /etc/ssh/ssh_known_hosts'
# git clone git@github.com:Crola1702-buildfarm/chef-nginx-ws.git

cd chef-nginx-ws/crola-chef
# sops -d -i data_bags/key_databag/sops-key.json

export other="Another variable"
sudo cinc-solo -c ".chef/solo.rb" -E "$SOPS_AGE_KEY" -j "solo/nginx_web_server.json"
# sudo cinc-solo -c ".chef/solo.rb" -j "solo/sops_test.json"

echo "Installed sops version: $(sops --version)"

echo "Check that key was decrypted"
cat data_bags/key_databag/sops-key.json

echo "Cleaning up"
sudo rm -rf chef-nginx-ws

echo "Done"
