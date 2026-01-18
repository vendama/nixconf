# My Nix Configurations
Config files for all my Nix machines.
## Installation Guide
Install minimal ISO from the [nixos website](https://nixos.org)
Flash the ISO to a USB
```bash
# Example, version will differ
sudo dd if=~/Downloads/nixos-minimal-25.11.2518.5900a0a8850c-x86_64-linux.iso of=/dev/sdX status = progress
```
Boot the ISO on the desired device.
(Optional if using SSH)Set the password on the live iso(keyboard and display are required)
```bash
passwd nixos
```
Now SSH in or continue in the console.
Get the disko configuration for the host and save it to /tmp/disko.nix
(in this example for host gemini)
```bash
curl https://raw.githubusercontent.com/vendama/nixconf/refs/heads/master/hosts/gemini/disko.nix -o /tmp/disko.nix
```
Run disko
```bash
sudo nix --experimental-features "nix-command flakes" run github:nix-community/disko -- --mode disko /tmp/disko.nix
# If using luks it will prompt for password here
```
Verify the disks are partitioned & mounted.
```bash
lsblk
```
Create directory for NixOS configuration
```bash
sudo mkdir -p /mnt/etc/nixos
```
Get the configuration
```bash
# in this example pullin the repo
cd /mnt/etc/nixos
sudo git init
sudo git pull https://github.com/vendama/nixconf.git
```
If this is a new device without a hardware configuration or the hardware has changed you might have to generate it here
```bash
sudo nixos-generate-config --no-filesystems --root /mnt --dir /mnt/etc/nixos/HOST/
```
Install NixOS
```bash
sudo nixos-install --root /mnt --flake /mnt/etc/nixos#host-CHANGEME
# After some time there will be a prompt for setting thre root password
```
Set user password
```bash
# in this example the vendama user
sudo nixos-enter -c 'passwd vendama'
```
Reboot into system
(optional) Post install
log in as user
clone the repo into home
```bash
git clone https://github.com/vendama/nixconf.git ~/nixconf
sudo rm -rf /etc/nixos/*

# From now on rebuild with
sudo nixos-rebuild switch --flake ~/nixconf
```
