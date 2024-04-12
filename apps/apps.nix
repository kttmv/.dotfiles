{ config, pkgs, ... }:
{
  imports = [
    ./fish.nix
    ./neovim.nix
  ];

  environment.systemPackages = with pkgs; [
    anytype
    dotnetCorePackages.dotnet_8.runtime
    dotnetCorePackages.dotnet_8.sdk
    dotnetPackages.Nuget
    gcc
    git
    gnome.gnome-calculator
    gnome.gnome-tweaks
    gnome.nautilus # file manager
    kitty
    lazygit
    microsoft-edge-dev
    nodejs_21
    obsidian
    okular # pdf reader
    onlyoffice-bin
    pinta
    psensor
    python3
    rustup
    vscode
    webcord # electron wrapper for web version of discrod
    wget
    wineWowPackages.waylandFull
  ];

}
