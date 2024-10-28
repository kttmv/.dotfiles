{ pkgs, ... }:

let
  packages = with pkgs; [ git ];
in
{
  imports = [
    ./fish.nix
  ];

  environment.systemPackages = packages;
}
