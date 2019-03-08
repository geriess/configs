#!/bin/bash

set -eu

# get droplet hostname
export HOSTNAME=$(curl -s http://169.254.169.254/metadata/v1/hostname)

# get droplet ip
export PUBLIC_IPV4=$(curl -s http://169.254.169.254/metadata/v1/interfaces/public/0/ipv4/address)

export DEBIAN_FRONTEND=noninteractive

echo Hello from Droplet $HOSTNAME, with IP Address: $PUBLIC_IPV4

# # add user
# adduser geries

# # add user to sudo group
# usermod -aG sudo geries

# update & upgrade
apt-get update
apt-get upgrade -y

# install
apt-get install -qq -y \
  docker.io \
  openssh-server

echo "Creating directories"
mkdir -p /mnt/code /mnt/secrets

echo "=> Setting up dev service"
cat > dockerdev.service <<EOF

[Unit]
Description=dockerdev
Requires=docker.service
After=docker.service

[Service]
TimeoutStartSec=0
ExecStartPre=-/usr/bin/docker kill dev
ExecStartPre=-/usr/bin/docker rm dev
ExecStartPre=/usr/bin/docker pull geries/dev:latest
ExecStart=/usr/bin/docker run -h dev -e TZ=America/Chicago --net=host --rm -v /var/run/docker.sock:/var/run/docker.sock -v /mnt/code:/root/code -v /mnt/secrets:/root/secrets --cap-add=SYS_PTRACE --security-opt seccomp=unconfined --privileged --name dev geries/dev:latest

[Install]
WantedBy=multi-user.target
EOF

sudo mv dockerdev.service /etc/systemd/system/
sudo systemctl daemon-reload
sudo systemctl enable dockerdev
sudo systemctl start dockerdev

echo "Done!"
