{ pkgs, ... }:

let
  packages = with pkgs; [ git ];
  #packagesListMongoDB = with mongodb-pkgs; [ mongodb mongosh ];
in
{
  imports = [
    ./fish.nix
  ];

  environment.systemPackages = packages;# ++ packagesListMongoDB;
}
