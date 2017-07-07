# packer_terraform_practice
Learning simple packer and terraform set up with a django app


### This repo contains:
1. ubuntu_with_django_app.json: *Packer* json file that puts the django app files on an ubuntu image
2. terraform.tf: A *Terraform* script that brings up a security group with ingress to port 8000, 80, and 22 (ssh), two instances with the image created by packer script, and an ELB with those two instances on it. 
3. run_app.sh: [UNUSED] A *Bash* script that I was trying to run from terraform on instance launch. This won't work because the script runs the app, which doesn't return, so terraform can't finish creating the instance.
4. runapp.service: A *Systemd* (like init, for latest Ubuntu/Red Hat) script that I plan to put onto the image in packer. This will run at instance boot. The reason this is in instance_name dir is for ease of copying it to the remote instance.
5. instance_name: The *Python/Django* app. Returns the id of the AWS instance it's running on. Easy to see that the ELB is doing its job. 
6. SCRIPTS:
	a. django_app.sh: A *Bash* script that moves the django app files from instance's tmp dir into another dir, creates and activates a virtualenv with Python 3.5, and installs app's requirements from its req file. 
	b. enable_service.sh: A *Bash* script to move the runapp.service into its proper dir (/etc/systemd/system) and enable it so that it will start automatically on instance boot.
