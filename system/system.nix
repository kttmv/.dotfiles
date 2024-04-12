{ config, pkgs, ... }:

{
  imports = [
    ./hardware-configuration.nix
    ./hyprland.nix
    ./libraries.nix
    ./fonts.nix
    ./mount.nix
    ./users.nix
    ./services.nix
    ./xserver.nix
    ./locale.nix
    ./sound.nix
    ./networking.nix
    ./bootloader.nix
    ./nix.nix
  ];

  system.stateVersion = "23.11"; # Do not change
}
