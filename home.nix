{ config, pkgs, ... }:

{
  home.username = "vlad";
  home.homeDirectory = "/home/vlad";

  home.packages = with pkgs; [ ];

  programs.zellij.enable = true;

  home.file = {
    ".config" = {
      source = ./.config;
      recursive = true;
    };
  };

  programs.home-manager.enable = true;

  home.stateVersion = "23.11"; # Do not change
}
