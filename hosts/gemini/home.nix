{ pkgs, ... }:
{
  imports = [
    ../../shared/home/firefox.nix
  ];

  programs.plasma = {
    enable = true;
    session.sessionRestore.restoreOpenApplicationsOnLogin = "startWithEmptySession";
    workspace.lookAndFeel = "org.kde.breezedark.desktop";
    input.keyboard.repeatDelay = 200;
    input.keyboard.repeatRate = 35;

    input.mice = [
      {
        accelerationProfile = "none";

        # Info from /proc/bus/input/devices
        name = "Logitech USB Receiver";
        vendorId = "046d";
        productId = "c547";
      }
    ];
    shortcuts = {
      "services/Ghostty.desktop"."_launch[$i]" = "Ctrl+Alt+T";
    };
    configFile = {
      # 2x faster animations
      kdeglobals.KDE.AnimationDurationFactor = 0.5;

      kdeglobals.General.TerminalApplication = "ghostty";
      kdeglobals.General.TerminalService = "Ghostty.desktop";
    };

    immutableByDefault = true;
  };

  # Fix Steam not using breeze cursor
  # Source: https://github.com/ValveSoftware/steam-for-linux/issues/11484
  home.file.".local/share/icons/default" = {
    source = "${pkgs.kdePackages.breeze}/share/icons/breeze_cursors";
    recursive = true;
  };

  home.stateVersion = "25.11";
}
