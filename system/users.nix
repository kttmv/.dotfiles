{ config, pkgs, ... }:

{
  users = {
    users.vlad = {
      isNormalUser = true;
      description = "Vlad";
      extraGroups = [ "networkmanager" "wheel" ];
    };
  };
}
