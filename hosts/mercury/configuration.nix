{pkgs, ...}: {
  networking.hostName = "mercury";

  imports = [
    ../../shared/firefox
  ];

  boot = {
    loader.systemd-boot.enable = true;
    loader.efi.canTouchEfiVariables = true;
    loader.timeout = 1;

    plymouth.enable = true;
    initrd.systemd.enable = true; # Also use plymouth for password prompt
  };

  zramSwap = {
    enable = true;
    memoryPercent = 100;
  };

  users.users.vendama = {
    extraGroups = ["wheel" "networkmanager"];
    isNormalUser = true;
  };

  environment.systemPackages = with pkgs; [
    kdePackages.kclock # Clock and timer app for kde
  ];

  services.xserver.xkb.layout = "de";
  console.keyMap = "de-latin1-nodeadkeys";

  services.displayManager.sddm = {
    enable = true;
    wayland.enable = true;
  };
  services.desktopManager.plasma6.enable = true;

  hardware.bluetooth.enable = true;

  services.printing.enable = true;
}
