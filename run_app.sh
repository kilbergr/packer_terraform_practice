#!/usr/bin/env bash

# Get into correct dir
pushd instance_name/

# Get into aws_project env
source aws_project/bin/activate

# Run Python app
python manage.py runserver 0.0.0.0:8000


# BELOW: This is what the above looks like in a systemd service
# [Unit]
# Description=My Django Python Script Service
# After=network.target

# [Service]
# Type=simple
# ExecStart=/home/ubuntu/instance_name/aws_project/bin/python /home/ubuntu/instance_name/manage.py runserver 0.0.0.0:8000

# [Install]
# WantedBy=multi-user.target