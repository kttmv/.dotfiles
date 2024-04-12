{ config, pkgs, ... }:

{
  users = {
    defaultUserShell = pkgs.fish;

    users.vlad = {
      isNormalUser = true;
      description = "Vlad";
      extraGroups = [ "networkmanager" "wheel" ];
    };
  };
}
