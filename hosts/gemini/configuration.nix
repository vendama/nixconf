{
  pkgs,
  lib,
  ...
}: {
  networking.hostName = "gemini";

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
    kernelPackages = pkgs.linuxPackages_latest;
    initrd.verbose = false;
    consoleLogLevel = 0;
    kernelParams = [
      "quiet"
    ];
  };

  nixpkgs.config.allowUnfreePredicate = pkg:
    builtins.elem (lib.getName pkg) [
      "steam"
      "steam-unwrapped"
    ];

  environment.systemPackages = with pkgs; [
  ];

  environment.plasma6.excludePackages = with pkgs; [
    kdePackages.falkon
    kdePackages.konsole
  ];

  programs.steam.enable = true;

  zramSwap = {
    enable = true;
    memoryPercent = 100;
  };

  users.users.vendama = {
    extraGroups = ["wheel" "networkmanager"];
    isNormalUser = true;
    packages = with pkgs; [
      kdePackages.kclock
      kdePackages.dragon
      element-desktop
      vesktop

      zed-editor
      clang-tools
      nil
      ghostty
      nerd-fonts.iosevka-term
      tmux
      neovim
    ];
  };

  services.xserver.xkb.layout = "de";
  console.keyMap = "de-latin1-nodeadkeys";
  services.displayManager.sddm = {
    enable = true;
    wayland.enable = true;
  };
  services.desktopManager.plasma6.enable = true;
  services.xserver.excludePackages = [pkgs.xterm];

  services.printing.enable = true;

  hardware.steam-hardware.enable = true;
  hardware.graphics.enable32Bit = true;

  # Load GPU early
  hardware.amdgpu.initrd.enable = true;

  # Enable overclocking
  hardware.amdgpu.overdrive.enable = true;
  services.lact.enable = true;
  environment.etc."lact/config.yaml".source = pkgs.writeTextFile {
    name = "config.yaml";
    text = builtins.readFile ./lact-config.yaml;
  };
}
