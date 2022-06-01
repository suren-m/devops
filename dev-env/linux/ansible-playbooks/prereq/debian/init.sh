#!/bin/bash

# Meant to be run just once right after creating a brand new Debian WSL2 install
# Last tested on buster

# pre-req
sudo apt update -y && sudo apt upgrade -y

# python-apt needed for ansible --check
sudo apt install -y wget git ansible python3-apt

# create backup dir
backup_dir="$HOME/.config/backup"
mkdir -p $backup_dir;

# timestamp
now=`date +%s`

# backup .bashrc
cp ~/.bashrc $backup_dir/.bashrc.orig

# disable password for sudoers
# backup sudoers
sudo cp /etc/sudoers $backup_dir/sudoers.orig_$now
sudo cp ./patched/sudoers /etc/sudoers

echo 'Installed pre-req'
echo 'done'

