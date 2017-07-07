# Move runapp.service to its proper location
sudo mv /home/ubuntu/instance_name/runapp.service /etc/systemd/system/runapp.service

# reload daemon
sudo systemctl daemon-reload

# enable runapp.service so it'll be 'active' and automatically start on boot
sudo systemctl enable runapp.service
