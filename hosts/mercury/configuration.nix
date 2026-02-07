{pkgs, ...}: {
  networking.hostName = "mercury";

  imports = [
    ./hardware-configuration.nix
    ../../shared/dnscrypt-proxy.nix
    ../../shared/firefox
  ];

  boot = {
    loader.systemd-boot.enable = true;
    loader.efi.canTouchEfiVariables = true;
    loader.timeout = 0;

    plymouth.enable = true;
    initrd.systemd.enable = true;
    initrd.verbose = false;
    consoleLogLevel = 0;
    kernelParams = [
      "quiet"
    ];
  };

  zramSwap = {
    enable = true;
    memoryPercent = 100;
  };

  users.users.vendama = {
    extraGroups = ["wheel" "networkmanager"];
    isNormalUser = true;
    packages = with pkgs; [
      ghostty
      mission-center
    ];
  };

  services.xserver.xkb.layout = "de";
  console.keyMap = "de-latin1-nodeadkeys";

  services.displayManager.gdm.enable = true;
  services.desktopManager.gnome.enable = true;
  environment.gnome.excludePackages = with pkgs; [
    gnome-tour
    yelp
    epiphany
    geary
    gnome-console
    gnome-system-monitor
  ];
  services.xserver.excludePackages = [pkgs.xterm];

  hardware.bluetooth.enable = true;

  services.printing.enable = true;
}
