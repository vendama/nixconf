# My Nix Configurations
This repo contains all of my nix configuration(s). This repo does not contain my dotfiles as I don't use nix for my dotfiles
## Installation Guide
1. Install minimal ISO from the (nixos website)[https://nixos.org]
2. Flash the ISO to a USB
```
# Example, version will differ
sudo dd if=~/Downloads/nixos-minimal-25.11.2518.5900a0a8850c-x86_64-linux.iso of=/dev/sdX status = progress
```
3. Boot the ISO on the desired device.
On headless devices this can be done with efibootmgr however you still need to connect a monitor and keyboard for SSH access. Otherwise I recommend doing it in the UEFI
This might also be usefull if your device is using fast boot which might not allow you to go into the uefi
```
# Get the USB boot num
efibootmgr
# Set the next boot num
sudo efibootmgr -n XXXX
```
4. (Optional if using SSH)Set the password on the live iso(keyboard and display are required)
```
passwd nixos
```
5. Now SSH into the machine or continue in the console.
6. Get the disko configuration for the host and save it to /tmp/disko.nix
(in this example for host gemini)
```
curl -LO https://raw.githubusercontent.com/vendama/nixconf/refs/heads/master/hosts/gemini/disko.nix
```
8. Run disko
```
sudo nix --experimental-features "nix-command flakes" run github:nix-community/disko -- --mode disko /tmp/disko.nix
# If using luks it will prompt for password here
```
Now the partition scheme should be correctly configured and mounted. Verify with lsblk.
```
lsblk
```
9. Create directory for NixOS configuration
```
sudo mkdir -p /mnt/etc/nixos
```
10. Get the configuration **TODO NOT VERIFIED**
```
# in this example pullin the repo
cd /mnt/etc/nixos
sudo git init
sudo git pull https://github.com/vendama/nixconf.git
```
11. If this is a new device without a hardware configuration or the hardware has changed you might have to generate it here
```
sudo nixos-generate-config --no-filesystems --root /mnt --dir /mnt/etc/nixos/HOST/
```
12. Install NixOS
NOTE: at the time of writing I have found this to core dump for some reason on first run, just rerun and it should just work
```
sudo nixos-install --root /mnt --flake /mnt/etc/nixos#host-CHANGEME
# After some time there will be a prompt for setting thre root password
```
13. Set user password
```
# in this example the vendama user
sudo nixos-enter -c 'passwd vendama'
```
14. Reboot into system
15. Post install
log in as user
clone the repo into home
```
git clone https://github.com/vendama/nixconf.git ~/nixconf
# Remove old nix files WARNING: Destructive
sudo rm -rf /etc/nixos/*

# From now on rebuild with
sudo nixos-rebuild switch --flake ~/nixconf
```
