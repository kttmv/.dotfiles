{ config, pkgs, ... }:

{
  xdg.portal = {
    enable = true;
    extraPortals = [ pkgs.xdg-desktop-portal-hyprland ];
  };

  environment.variables.NIXOS_OZONE_WL = "1";

  programs.hyprland = {
    enable = true;
    xwayland.enable = true;
  };

  environment.systemPackages = with pkgs; [
    waybar # status bar
    dunst # notification daemon
    libnotify # dunst depends on this
    swww # wallpaper daemon
    wofi # application launcher
    rofi # application launcher, used for password prompt
    brightnessctl # a program to change brightness
    networkmanagerapplet # tray app to connect to wifi
    hyprshot # screenshots for hyprland
    hyprlock # screen locking utility
    gnome.gnome-calculator # calculator
    gnome.nautilus # file manager
    kitty # default terminal emulator in hyprland
    wlogout # logout menu
  ];
}
