{pkgs, ...}: {
  imports = [
    ../../shared/home/firefox.nix
  ];

  # Fix Steam not using breeze cursor
  # Source: https://github.com/ValveSoftware/steam-for-linux/issues/11484
  home.file.".local/share/icons/default" = {
    source = "${pkgs.kdePackages.breeze}/share/icons/breeze_cursors";
    recursive = true;
  };

  home.stateVersion = "25.11";
}
