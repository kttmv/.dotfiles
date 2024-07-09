{ config, pkgs, ... }:
{
  imports = [
    ./fish.nix
    ./neovim.nix
  ];

  environment.systemPackages = with pkgs; [
  ];
}
