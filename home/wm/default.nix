{ config, pkgs, ... }:

{
  imports = [
    ./hyprland/default.nix
    ./waybar/default.nix
  ];
}
