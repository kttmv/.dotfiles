{ config, pkgs, ... }:
{
  imports = [
    ./fish.nix
    ./neovim.nix
  ];

  environment.systemPackages = with pkgs; [
    obsidian # notes on steroids
    okular # pdf reader
    onlyoffice-bin # office alternative
    pinta # paint alternative
    gh # github
    helix # vim killer (?)
    lazygit # nice terminal ui for git
    microsoft-edge-dev # an evil browser
    vscode # an evil code editor
    webcord # electron wrapper for web version of discrod
    zellij # a tmux killer

    dotnetCorePackages.dotnet_8.runtime
    dotnetCorePackages.dotnet_8.sdk
    dotnetPackages.Nuget
    firefox
    gcc
    git
    gnome.gnome-tweaks
    nh # "nh os/home switch" command
    nodejs_21
    python3
    rustup
    wget
    wineWowPackages.waylandFull
  ];
}
