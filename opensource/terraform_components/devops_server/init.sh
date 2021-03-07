#!/bin/bash -x
sudo apt update
sudo apt install python3.8 -y
sudo apt install software-properties-common -y
sudo apt-add-repository --yes --update ppa:ansible/ansible
sudo apt install ansible -y
sudo apt install git-all -y
sudo apt install python3-pip -yes
pip3 install boto3
ansible-galaxy collection install amazon.aws
ansible-galaxy collection install community.aws
# Make aws profile file
mkdir ~/.aws
touch ~/.aws/config
