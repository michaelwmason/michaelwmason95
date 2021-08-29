#!/bin/bash -x
sudo apt update
sudo apt install python3.8 -y
sudo apt install software-properties-common -y
sudo apt-add-repository --yes --update ppa:ansible/ansible
sudo apt install ansible -y
sudo apt install git-all -y
sudo apt install python3-pip -y
pip3 install boto3
apt install python3-boto3 -y
ansible-galaxy collection install amazon.aws
ansible-galaxy collection install community.aws
echo "Git credentials need to be added manually"
echo "SSH Key needs to be added manually for ansible use"