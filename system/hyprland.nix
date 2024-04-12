{ config, pkgs, ... }:

{
  xdg.portal = {
    enable = true;
    # extraPortals = [ pkgs.xdg-desktop-portal-gtk ];
  };

  programs.hyprland = {
    enable = true;
    xwayland.enable = true;
  };

  environment.systemPackages = with pkgs; [
    waybar # bar
    dunst # notification daemon
    libnotify # dunst depends on this
    swww # wallpaper daemon
    wofi # application launcher
    brightnessctl # a program to change brightness
    networkmanagerapplet # tray app to connect to wifi
    hyprshot # screenshots for hyprland
  ];
}
