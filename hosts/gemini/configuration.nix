{ ... }:
{
  networking.hostName = "gemini";

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

  services.fwupd.enable = true;

  zramSwap = {
    enable = true;
    memoryPercent = 100;
  };

  users.users.vendama = {
    extraGroups = [ "wheel" "networkmanager" ];
  };

  services.xserver.xkb.layout = "de";
  console.keyMap = "de-nodeadkeys"; services.displayManager.sddm = { enable = true; wayland.enable = true; };
  services.desktopManager.plasma6.enable = true;
  services.xserver.excludePackages = [ pkgs.xterm ];

  services.printing.enable = true;

  # Enable pipewire. Technically not required when a desktopManager is enabled.
  services.pipewire = {
    enable = true;
    pulse.enable = true;
    jack.enable = true;
  };

  hardware.steam-hardware.enable = true;
  hardwaare.xone.enable = true;
  hardware.graphics.enable32Bit = true;
}
