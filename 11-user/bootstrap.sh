#!/bin/bash 
component=$1
environment=$2 # don't use env as variable here, It is reserved for linux
yum install python3.11-devel python3.11-pip -y 
pip3.11 install ansible botocore boto3
export PATH=$PATH:/usr/local/bin
ansible-pull -U https://github.com/devopsprocloud/roboshop-ansible-roles-terraform.git -e component=$component -e env=$environment main-terraform.yaml