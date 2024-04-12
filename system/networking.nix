{ config, pkgs, ... }:

{
  imports = [
    ./wireguard.nix
  ];

  networking.hostName = "nixos";
  networking.networkmanager.enable = true;
}
