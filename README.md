# Nix Configurations
## Installation Guide
This guide only applies to NixOS.
Flash & Boot the ISO.
Get the disko configuration & run disko
```bash
curl -LO https://raw.githubusercontent.com/vendama/nixconf/refs/heads/master/hosts/gemini/disko.nix
sudo nix --experimental-features "nix-command flakes" run github:nix-community/disko -- --mode disko disko.nix
```
Verify the disk(s) is partitioned & mounted.
```bash
lsblk
```
Create dir and clone config
```bash
sudo mkdir -p /mnt/etc/
sudo git clone https://github.com/vendama/nixconf /mnt/etc/nixos
```
Might have to generate hardware config
```bash
sudo nixos-generate-config --no-filesystems --root /mnt --dir /mnt/etc/nixos/HOST/
```
Install NixOS
```bash
sudo nixos-install --root /mnt --flake /mnt/etc/nixos#HOST
```
Set password
```bash
sudo nixos-enter -c 'passwd USER'
```
Reboot into system

## Post install
log in as user
clone the repo into home
```bash
git clone https://github.com/vendama/nixconf.git ~/Documents/nixconf
sudo rm -rf /etc/nixos/*
```
