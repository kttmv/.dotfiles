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
    nh # nix cli helper 
    firefox # not so evil browser

    dotnetCorePackages.dotnet_8.runtime
    dotnetCorePackages.dotnet_8.sdk
    dotnetPackages.Nuget
    gcc
    git
    gnome.gnome-tweaks
    nodejs_21
    python3
    rustup
    wget
    wineWowPackages.waylandFull
  ];
}
