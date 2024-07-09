{ config, pkgs, ... }:

{
  services = {
    displayManager = {
      # gdm.enable = true;
      # lightdm.enable = true;
      sddm.enable = true;
    };
    xserver = {
      enable = true;
      xkb = {
        layout = "us";
        variant = "";
      };
      desktopManager = {
        # gnome.enable = true;
        # deepin.enable = true;
      };
    };
  };
}
