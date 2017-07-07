#!/usr/bin/env bash

# Get into correct dir
pushd instance_name/

# Get into aws_project env
source aws_project/bin/activate

# Run Python app
python manage.py runserver 0.0.0.0:8000
