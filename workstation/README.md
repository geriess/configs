# Workstation build

This terraform setup creates a workstation on DigitalOcean with my personal
setup and ready to use mosh setup.

## Install


1. Create workstation droplet

``
$ export DO_TOKEN="Put Your Token Here"
$ terraform plan -var "do_token=${DO_TOKEN}"
$ terraform apply -auto-approve -var "do_token=${DO_TOKEN}"
``

2. SSH via mosh:

``
$ mosh --no-init --ssh="ssh -o StrictHostKeyChecking=no -i ~/.ssh/github_rsa -p 3222" root@<DROPLET_IP> -- tmux new-session -AD -s main
$ cd ~/secrets && ./pull-secrets.sh
``


## Todo

