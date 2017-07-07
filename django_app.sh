#!/usr/bin/env bash
# Install pip
sudo apt-get install python-pip -y

# Set PATH so virtualenv can be found
PATH=$PATH:/home/ubuntu/.local/bin

# Install virtualenv
pip install virtualenv

# Move relevant dir from tmp to permanent dir
pushd /tmp/
mv /tmp/instance_name /home/ubuntu/

# Leave tmp
popd

# Go to instance_name dir
pushd instance_name/

# This creates a virtualenv and activates
virtualenv -p /usr/bin/python3.5 aws_project
source aws_project/bin/activate

# Install requirements in virtualenv
pip install -r requirements.txt
