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

    (with dotnetCorePackages; combinePackages [
      sdk_7_0
      sdk_8_0
    ])

    dotnetPackages.Nuget
    gcc
    git
    nodePackages_latest.nodejs
    python3
    rustup
    wget
    wineWowPackages.waylandFull
  ];
}
