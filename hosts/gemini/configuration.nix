{ pkgs, lib, ... }:
{
  networking.hostName = "gemini";

  imports = [
    ./hardware-configuration.nix
    ./gpu-screen-recorder-ui/gpu-screen-recorder-ui.nix # Copied from pr 369574
  ];

  boot = {
    loader.systemd-boot.enable = true;
    loader.efi.canTouchEfiVariables = true;
    loader.timeout = 0; # Hold button to access boot menu

    plymouth.enable = true;
    initrd.systemd.enable = true; # Also use plymouth for password prompt
    initrd.verbose = false;
    kernelPackages = pkgs.linuxPackages_latest; # Use latest instead of lts
    # Quiet graphics boot
    kernelParams = [
      "quiet"
      "loglevel=3"
      "rd.systemd.show_status=false"
      "rd.udev.log_level=3"
      "udev.log_priority=3"
    ];
  };

  nixpkgs.config.allowUnfreePredicate = pkg: builtins.elem (lib.getName pkg) [
    "steam"
    "steam-unwrapped"
  ];

  environment.systemPackages = with pkgs; [
    git
  ];

  environment.plasma6.excludePackages = with pkgs; [
    kdePackages.falkon
  ];

  programs.steam.enable = true;

  services.fwupd.enable = true;

  zramSwap = {
    enable = true;
    memoryPercent = 100;
  };

  users.users.vendama = {
    extraGroups = [ "wheel" "networkmanager" ];
    isNormalUser = true;
    packages = with pkgs; [
      element-desktop
      prismlauncher
    ];
  };

  services.xserver.xkb.layout = "de";
  console.keyMap = "de-nodeadkeys"; services.displayManager.sddm = { enable = true; wayland.enable = true; };
  services.desktopManager.plasma6.enable = true;
  services.xserver.excludePackages = [ pkgs.xterm ];

  services.printing.enable = true;

  hardware.steam-hardware.enable = true;
  hardware.graphics.enable32Bit = true;

  programs.gpu-screen-recorder = true;
  programs.gpu-screen-recorder-ui.enable = true;
}
