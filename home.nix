{ config, pkgs, ... }:

{
  gtk = {
    enable = true;
    theme = {
      name = "Breeze-Dark";
      package = pkgs.libsForQt5.breeze-gtk;
    };
    font.name = "Ubuntu";
  };

  dconf.settings = {
    "org/gnome/desktop/interface" = {
      color-scheme = "prefer-dark";
    };
  };

  home.username = "vlad";
  home.homeDirectory = "/home/vlad";

  home.packages = with pkgs; [ ];

  home.file = {
    ".config" = {
      source = ./.config;
      recursive = true;
    };
  };

  nixpkgs.config = {
    allowUnfree = true;
    allowUnfreePredicate = (_: true);
  };

  programs.home-manager.enable = true;

  home.stateVersion = "23.11"; # Do not change
}
