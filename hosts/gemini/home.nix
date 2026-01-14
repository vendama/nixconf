{ pkgs, ... }:
{
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
