{ config, pkgs, ... }:

{
  services = {
    xserver = {
      enable = true;
      xkb = {
        layout = "us";
        variant = "";
      };
      displayManager = {
        # gdm.enable = true;
        # lightdm.enable = true;
        sddm.enable = true;
      };
      desktopManager = {
        # gnome.enable = true;
        # deepin.enable = true;
      };
    };
  };
}
