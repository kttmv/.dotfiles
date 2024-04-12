{ config, pkgs, ... }:

{
  imports = [
    ./apps/apps.nix
    ./system/system.nix
  ];
}
