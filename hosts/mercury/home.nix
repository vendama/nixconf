{ ... }:
{
  imports = [
    ../shared/home/firefox.nix
  ];
  programs.plasma = {
    enable = true;
    workspace.lookAndFeel = "org.kde.breezedark.desktop";
    immutableByDefault = true;
  };
  home.stateVersion = "25.11";
}
