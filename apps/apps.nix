{ config, pkgs, ... }:
{
  imports = [
    ./fish.nix
  ];

  environment.systemPackages = with pkgs; [
    nodejs_21
    python3
    rustup
    ripgrep
    microsoft-edge-dev
    anytype
    xclip
    omnisharp-roslyn
    dotnetCorePackages.dotnet_8.sdk
    dotnetCorePackages.dotnet_8.runtime
    csharp-ls
    dotnetPackages.Nuget
    lazygit
    discord
    psensor
    cpufrequtils
    powerline
    gcc
    obsidian
    pinta
    onlyoffice-bin
    kitty
    nil # nix language server
    nixpkgs-fmt
    okular # pdf reader
    hyprshot # screenshots for hyprland
    wineWowPackages.waylandFull
    webcord # electron wrapper for web version of discrod
    vscode
    gnome.nautilus # file manager
    gnome.gnome-calculator
    git
    wget
    nerdfonts
    gnome.gnome-tweaks
    waybar # bar for hyprland
    dunst # notification daemon for hyprland
    libnotify # dunst depends on it
    swww # wallpaper daemon for hyprland
    wofi # application launcher
    zoxide # a smarter cd command
    brightnessctl # a program to change brightness
    networkmanagerapplet # tray app to connect to wifi
  ];

  programs.neovim = {
    enable = true;
    defaultEditor = true;
  };
}
